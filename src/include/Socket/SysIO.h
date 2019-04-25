/*
 * Socket.h
 *
 *  Created on: Mar 14, 2015
 *      Author: dzhou
 */

#ifndef SYSIO_H_
#define SYSIO_H_

#include <string>
#include <iostream>
// #include <openssl/ssl.h>
#include "SmartPointer.h"
#include "Types.h"


#define MAX_CAPACITY 65536
#define MAX_PACKET_SIZE 1400

#ifdef __APPLE__
	#define MSG_NOSIGNAL 0x2000
	#define ftello64 ftello
	#define fseeko64 fseeko
#endif

#ifdef LINUX
	#include <netinet/in.h>
    #include <netinet/tcp.h>
    #include <sys/socket.h>
	typedef int SOCKET;
	#define INVALID_SOCKET -1
	#define SOCKET_ERROR   -1
#else
	#undef Realloc
	#undef Free
	#include <winsock2.h>
	#include<windows.h>
#endif

using std::string;

class Constant;
class Socket;
class DataInputStream;
class DataOutputStream;
typedef SmartPointer<Socket> SocketSP;
typedef SmartPointer<DataInputStream> DataInputStreamSP;
typedef SmartPointer<DataOutputStream> DataOutputStreamSP;

class Socket{
public:
	Socket();
	Socket(const string& host, int port, bool blocking);
	Socket(SOCKET handle, bool blocking);
	~Socket();
	const string& getHost() const {return host_;}
	int getPort() const {return port_;}
	IO_ERR read(char* buffer, size_t length, size_t& actualLength, bool msgPeek = false);
	IO_ERR write(const char* buffer, size_t length, size_t& actualLength);
	IO_ERR bind();
	IO_ERR listen();
	IO_ERR connect(const string& host, int port, bool blocking);
	IO_ERR connect();
	IO_ERR close();
	Socket* accept();
	SOCKET getHandle();
	bool isBlockingMode() const {return blocking_;}
	bool isValid();
	void setAutoClose(bool option) { autoClose_ = option;}
	// void enableSSL(SSL* ssl) { ssl_ = ssl;}
	// SSL* getSSL() const { return ssl_;}
	static bool ENABLE_TCP_NODELAY;

private:
	bool setNonBlocking();
	bool setTcpNoDelay();
	int getErrorCode();
	void showSSLError(int err);

private:
	string host_;
	int port_;
	SOCKET handle_;
	bool blocking_;
	bool autoClose_;
	// SSL* ssl_;
};

class DataInputStream{
public:
	DataInputStream(STREAM_TYPE type, int bufSize = 2048);
	DataInputStream(const char* data, int size, bool copy = true);
	DataInputStream(const SocketSP& socket, int bufSize = 2048);
	DataInputStream(FILE* file, int bufSize = 2048);
	virtual ~DataInputStream();
	IO_ERR close();
	void enableReverseIntegerByteOrder() { reverseOrder_ = true;}
	void disableReverseIntegerByteOrder() { reverseOrder_ = false;}
	IO_ERR bufferBytes(size_t length);
	IO_ERR read(char* buf, size_t length) { return readBytes(buf, length, false);}
	IO_ERR readBytes(char* buf, size_t length, bool reverseOrder);

	/**
	 * This method is designed to read a large block of stream data.  When the length is too small, say less than 8192,
	 * it may affect IO throughput. This method first retrieves data from the buffer and reads the remaining from the
	 * underlying device.
	 */
	IO_ERR readBytes(char* buf, size_t length, size_t& actualLength);
	IO_ERR readBytes(char* buf, size_t unitLength, size_t length, size_t& actualLength);
	IO_ERR readBool(bool& value);
	IO_ERR readBool(char& value);
	IO_ERR readChar(char& value);
	IO_ERR readUnsignedChar(unsigned char& value);
	IO_ERR readShort(short& value);
	IO_ERR readUnsignedShort(unsigned short& value);
	IO_ERR readInt(int& value);
	IO_ERR readUnsignedInt(unsigned int& value);
	IO_ERR readLong(long long& value);
	IO_ERR readIndex(INDEX& value);
	IO_ERR readFloat(float& value);
	IO_ERR readDouble(double& value);
	IO_ERR readString(string& value);
	IO_ERR readString(string& value, size_t length);
	IO_ERR readLine(string& value);
	/**
	 * Preview the given size of stream data from the current position. The internal current position will not change
	 * after this operation. If the available data in the internal buffer from the current position is less than the
	 * requested size, the method will read data from the socket and be blocked or immediately return an error if there
	 * is not data available unfortunately depending on the socket mode, blocking or non-blocking.
	 */
	IO_ERR peekBuffer(char* buf, size_t size);
	IO_ERR peekLine(string& value);

	inline bool isSocketStream() const {return source_ == SOCKET_STREAM;}
	inline bool isFileStream() const { return source_ == FILE_STREAM;}
	inline bool isArrayStream() const {return source_ == ARRAY_STREAM;}
	inline STREAM_TYPE getStreamType() const {return source_;}
	SocketSP getSocket() const { return socket_;}
	FILE* getFileHandle() const { return file_;}

	/**
	 * The position of the cursor in the file or buffer after last read. This function works for the case of file input or
	 * buffer input. It always return zero for socket input.
	 */
	long long getPosition() const;


	INDEX getDataSizeInArray() const { return size_;}
	bool isIntegerReversed() const {return reverseOrder_;}

	/**
	 * Move to the given position of a file.It always returns false for other type of stream.
	 * The internal buffer will be cleared if the file position is moved successfully.
	 */
	bool moveToPosition(long long offset);

	/**
	 * Reset the size of an external buffer. The cursor moves to the beginning of the buffer.
	 */
	bool reset(int size);

protected:
	/**
	 * Read up to number of bytes specified by the length. If the underlying device doesn't have even one byte
	 * or any other error occurs, return a IO error code other than OK.
	 */
	virtual IO_ERR internalStreamRead(char* buf, size_t length, size_t& actualLength);
	virtual IO_ERR internalClose();
	virtual bool internalMoveToPosition(long long offset){return false;}


private:
	IO_ERR prepareBytes(size_t length);
	IO_ERR prepareBytesEndWith(char endChar, size_t& endPos);

protected:
	SocketSP socket_;
	FILE* file_;
	char* buf_;
	STREAM_TYPE source_;
	bool reverseOrder_;
	bool externalBuf_;
	bool closed_;
	size_t capacity_;
	size_t size_;
	size_t cursor_;
};

class Buffer {
public:
	Buffer(size_t capacity) : buf_(new char[capacity]), capacity_(capacity), size_(0), external_(false){}
	Buffer() : buf_(new char[256]), capacity_(256), size_(0), external_(false){}
	Buffer(char* buf, size_t capacity) : buf_(buf), capacity_(capacity), size_(0), external_(true){}
	~Buffer() { if(!external_) delete[] buf_;}
	IO_ERR write(const char* buffer, int length, int& actualLength);
	IO_ERR write(const char* buffer, int length);
	inline IO_ERR write(const string& buffer){ return write(buffer.c_str(), buffer.length() + 1);}
	inline IO_ERR writeData(const string& buffer){ return write(buffer.data(), buffer.length());}
	inline IO_ERR write(bool val){ return write((const char*)&val, 1);}
	inline IO_ERR write(char val){ return write(&val, 1);}
	inline IO_ERR write(short val){ return write((const char*)&val, 2);}
	inline IO_ERR write(unsigned short val){ return write((const char*)&val, 2);}
	inline IO_ERR write(int val){ return write((const char*)&val, 4);}
	inline IO_ERR write(long long val){ return write((const char*)&val, 8);}
	inline IO_ERR write(float val){ return write((const char*)&val, 4);}
	inline IO_ERR write(double val){ return write((const char*)&val, 8);}
	size_t size() const { return size_;}
	size_t capacity() const { return capacity_;}
	const char * getBuffer() const { return buf_;}
	void clear();

private:
	char* buf_;
	size_t capacity_;
	size_t size_;
	bool external_;
};

template<class T>
class BufferWriter{
public:
	BufferWriter(const T& out) : out_(out), buffer_(0), size_(0){}

	IO_ERR start(const char* buffer, size_t length){
		IO_ERR ret = OK;
		size_t actualWritten = 0;

		buffer_ = (char*)buffer;
		size_ = length;
		while((ret = out_->write(buffer_, size_, actualWritten))==OK  && actualWritten < size_){
			buffer_ += actualWritten;
			size_ -= actualWritten;
		}
		if(ret == NOSPACE){
			buffer_ += actualWritten;
			size_ -= actualWritten;
		}
		else
			size_ = 0;
		return ret;
	}

	IO_ERR resume(){
		IO_ERR ret = OK;
		size_t actualWritten = 0;

		while((ret = out_->write(buffer_, size_, actualWritten))==OK  && actualWritten < size_){
			buffer_ += actualWritten;
			size_ -= actualWritten;
		}
		if(ret == NOSPACE){
			buffer_ += actualWritten;
			size_ -= actualWritten;
		}
		else
			size_ = 0;
		return ret;
	}

	inline size_t size() const { return size_;}
	inline T getDataOutputStream() const { return out_;}

private:
	T out_;
	char* buffer_;
	size_t size_;
};



struct FileAttributes{
	string name;
	bool isDir;
	long long size;
	long long lastModified; //epoch time in milliseconds
	long long lastAccessed; //epoch time in milliseconds
};



/*
 * Socket.cpp
 *
 *  Created on: Mar 14, 2015
 *      Author: dzhou
 */

#if defined LINUX
	#include <unistd.h>
	#include <netdb.h>
	#include <sys/types.h>
	#include <sys/socket.h>
	#include <arpa/inet.h>
	#include <fcntl.h>
	#define closesocket(s) ::close(s)
#else
	#undef UNICODE
	#include <winsock2.h>
	#include <ws2tcpip.h>
#endif

// #include "Util.h"
// #include "Logger.h"
#include <string.h>

bool Socket::ENABLE_TCP_NODELAY = true;

Socket::Socket():host_(""), port_(-1), blocking_(true), autoClose_(true){
    handle_ = socket(AF_INET, SOCK_STREAM, IPPROTO_TCP);
    if(INVALID_SOCKET == handle_) {
    	// throw IOException("Couldn't create a socket with error code " + Util::convert(getErrorCode()));
    }
	else if(!blocking_){
		setNonBlocking();
	}
    if(ENABLE_TCP_NODELAY)
    	setTcpNoDelay();
}

Socket::Socket(const string& host, int port, bool blocking) : host_(host), port_(port), blocking_(blocking), autoClose_(true){
	if(host.empty() && port > 0){
		//server mode
		handle_ = socket(AF_INET, SOCK_STREAM, IPPROTO_TCP);
		if(INVALID_SOCKET == handle_) {
			// throw IOException("Couldn't create a socket with error code " + Util::convert(getErrorCode()));
		}
		else if(!blocking_){
			setNonBlocking();
		}
	    if(ENABLE_TCP_NODELAY)
	    	setTcpNoDelay();
	}
	else if(!host.empty() && port > 0){
		//client mode

	}
	else
		handle_ = INVALID_SOCKET;
}

Socket::Socket(SOCKET handle, bool blocking):host_(""), port_(-1), handle_(handle), blocking_(blocking), autoClose_(true){
	if(INVALID_SOCKET == handle_) {
		// throw IOException("The given socket is invalid.");
	}
	else if(!blocking){
		setNonBlocking();
	}
    if(ENABLE_TCP_NODELAY)
    	setTcpNoDelay();
}

Socket::~Socket(){
	if(autoClose_)
		close();
}

bool Socket::isValid(){
	return handle_ != INVALID_SOCKET;
}

IO_ERR Socket::read(char* buffer, size_t length, size_t& actualLength, bool msgPeek){
	// if(ssl_ == NULL){
#ifdef WINDOWS
		actualLength=recv(handle_, buffer, length, msgPeek ? MSG_PEEK : 0);
		if(actualLength == 0)
			return DISCONNECTED;
		else if(actualLength != (size_t)SOCKET_ERROR)
			return OK;
		else{
			actualLength=0;
			int error=WSAGetLastError();
			if(error==WSAENOTCONN || error==WSAESHUTDOWN || error==WSAENETRESET)
				return DISCONNECTED;
			else if(error==WSAEWOULDBLOCK)
				return NODATA;
			else
				return OTHERERR;
		}
#else
		readdata:
		actualLength=recv(handle_, (void*)buffer, length, (blocking_ ? 0: MSG_DONTWAIT)|(msgPeek ? MSG_PEEK : 0));
		if(actualLength == (size_t)SOCKET_ERROR && errno == EINTR) goto readdata;

		if(actualLength == 0)
			return DISCONNECTED;
		else if(actualLength != (size_t)SOCKET_ERROR)
			return OK;
		else if(errno==EAGAIN || errno==EWOULDBLOCK)
			return NODATA;
		else{
			actualLength=0;
			return OTHERERR;
		}
#endif
	// }
	// else{
	// 	int ret = SSL_read(ssl_, buffer,length);
	// 	if(ret > 0){
	// 		actualLength = ret;
	// 		return OK;
	// 	}
	// 	else {
	// 		int errCode = SSL_get_error(ssl_, ret);
	// 		if(errCode != SSL_ERROR_WANT_READ){
	// 			showSSLError(errCode);
	// 			return OTHERERR;
	// 		}
	// 		else
	// 			return NODATA;
	// 	}
	// }
}

IO_ERR Socket::write(const char* buffer, size_t length, size_t& actualLength){
	// if(ssl_ == NULL){
#ifdef WINDOWS
		actualLength=send(handle_, buffer, length, 0);
		if(actualLength != (size_t)SOCKET_ERROR)
			return OK;
		else{
			actualLength=0;
			int error=WSAGetLastError();
			if(error==WSAENOTCONN || error==WSAESHUTDOWN || error==WSAENETRESET)
				return DISCONNECTED;
			else if(error==WSAEWOULDBLOCK || error==WSAENOBUFS)
				return NOSPACE;
			else{
				// LOG_ERR("Socket::write errno =", error);
				return OTHERERR;
			}
		}
#else
		senddata:
		actualLength=send(handle_, (const void*)buffer, length, blocking_ ? 0: MSG_DONTWAIT|MSG_NOSIGNAL);
		if(actualLength == (size_t)SOCKET_ERROR && errno == EINTR) goto senddata;

		if(actualLength != (size_t)SOCKET_ERROR)
			return OK;
		else{
			actualLength=0;
			if(errno==EAGAIN || errno==EWOULDBLOCK)
				return NOSPACE;
			else if(errno==ECONNRESET || errno==EPIPE || errno==EBADF || errno==ENOTCONN)
				return DISCONNECTED;
			else{
				// LOG_ERR("Socket::write errno =", errno);
				return OTHERERR;
			}
		}
#endif
	// }
	// else{
	// 	int ret= SSL_write(ssl_, buffer, length);
	// 	if(ret > 0){
	// 		actualLength = ret;
	// 		return OK;
	// 	}
	// 	else{
	// 		int errCode = SSL_get_error(ssl_, ret);
	// 		if(errCode != SSL_ERROR_WANT_WRITE){
	// 			showSSLError(errCode);
	// 			return OTHERERR;
	// 		}
	// 		else
	// 			return NOSPACE;
	// 	}
	// }
}

IO_ERR Socket::bind(){
	if(port_<0 || handle_==INVALID_SOCKET)
		return OTHERERR;

	struct sockaddr_in addr;
	memset((void*)&addr, 0, sizeof(addr));
	addr.sin_family      = AF_INET;
	addr.sin_addr.s_addr = htonl(INADDR_ANY);
	addr.sin_port        = htons(port_);

	int flag=0;
	setsockopt(handle_, SOL_SOCKET, SO_REUSEADDR, (char*)&flag, sizeof(int));
	int r = ::bind(handle_, (struct sockaddr*)&addr, sizeof(addr));
	if(SOCKET_ERROR == r) {
		// LOG_ERR("Failed to bind the socket on port " + Util::convert(port_) + " with error code " + Util::convert(getErrorCode()));
		closesocket(handle_);
		return OTHERERR;
	}
	return OK;
}

IO_ERR Socket::listen(){
    int r = ::listen(handle_, SOMAXCONN);
    if(r!=SOCKET_ERROR)
    	return OK;
    else{
    	// LOG_ERR("Failed to bind the socket on port " + Util::convert(port_) + " with error code " + Util::convert(getErrorCode()));
    	closesocket(handle_);
    	return OTHERERR;
    }
}

IO_ERR Socket::connect(const string& host, int port, bool blocking){
	host_ = host;
	port_ = port;
	blocking_ = blocking;
	return connect();
}

IO_ERR Socket::connect(){
	if(port_ == -1 || host_.empty())
		return OTHERERR;

	struct addrinfo hints, *servinfo, *p;
	memset(&hints, 0, sizeof hints);
	hints.ai_family = AF_INET;
	hints.ai_socktype = SOCK_STREAM;
	string portStr=std::to_string(port_);
	if (getaddrinfo(host_.c_str(), portStr.c_str(), &hints, &servinfo)!= 0) {
		// LOG_ERR("Failed to call getaddrinfo for host = " + host_ + " port = " + portStr + " with error code " + Util::convert(getErrorCode()));
		return OTHERERR;
	}

	// loop through all the results and connect to the first we can
	for(p = servinfo; p != NULL; p = p->ai_next) {
		if ((handle_ = socket(p->ai_family, p->ai_socktype,	p->ai_protocol)) == (SOCKET)SOCKET_ERROR)
			continue;
		if(!blocking_)
			setNonBlocking();
	    if(ENABLE_TCP_NODELAY)
	    	setTcpNoDelay();

		if(::connect(handle_, p->ai_addr, p->ai_addrlen) == SOCKET_ERROR) {
			if(!blocking_){
#ifdef WINDOWS
				if(WSAGetLastError () == WSAEWOULDBLOCK)
					return INPROGRESS;
#else
				if(errno == EINPROGRESS)
					return INPROGRESS;
#endif
			}
			// LOG_ERR("Failed to connect to host = " + host_ + " port = " + portStr + " with error code " + Util::convert(getErrorCode()));
			closesocket(handle_);
			handle_=INVALID_SOCKET;
			continue;
		}
		break;
	}
	if(handle_==INVALID_SOCKET)
		return DISCONNECTED;
	else
		return OK;
}

IO_ERR Socket::close(){
	if(handle_!=INVALID_SOCKET){
		// if(ssl_ != NULL){
		// 	SSL_shutdown(ssl_);
		// 	SSL_free(ssl_);
		// 	ssl_ = NULL;
		// }
		if(closesocket(handle_) != 0){
			//LOG_ERR("Failed to close the socket handle with error code " + Util::convert(getErrorCode()));
			handle_=INVALID_SOCKET;
			return OTHERERR;
		}
		handle_=INVALID_SOCKET;
	}
	return OK;
}

Socket* Socket::accept(){
	struct sockaddr_in r_addr;

#ifdef WINDOWS
	int addrLen=sizeof(r_addr);
#else
	socklen_t addrLen=sizeof(r_addr);
#endif
	SOCKET t = ::accept(handle_, (struct sockaddr*)&r_addr, &addrLen);
	if(t==INVALID_SOCKET){
#ifdef WINDOWS
		int errCode = WSAGetLastError();
		if(errCode != WSAEWOULDBLOCK) {}
			// LOG_ERR("Failed to accept one incoming connection with error code " + Util::convert(errCode));
#else
		int errCode = errno;
		if(errCode != EWOULDBLOCK && errCode != EAGAIN) {}
			// LOG_ERR("Failed to accept one incoming connection with error code " + Util::convert(errCode));
#endif
		return NULL;
	}
	else
		return new Socket(t, blocking_);
}

SOCKET Socket::getHandle(){
	return handle_;
}

bool Socket::setNonBlocking(){
#ifdef WINDOWS
	unsigned long value = 1;
	return ioctlsocket(handle_, FIONBIO, &value) == 0;
#else
	int flags = fcntl(handle_, F_GETFL, 0);
	if(flags == -1)
		return false;
	flags |= O_NONBLOCK;
	return fcntl (handle_, F_SETFL, flags) != -1;
#endif
}

bool Socket::setTcpNoDelay(){
	int ret;
#ifdef WINDOWS
	char value = 1;
	ret = setsockopt(handle_, IPPROTO_TCP, TCP_NODELAY, &value, sizeof(char));
#else
	int value = 1;
	ret = setsockopt(handle_, IPPROTO_TCP, TCP_NODELAY, (const void*)&value, sizeof(int));
#endif
	if(ret != 0){
		// LOG_ERR("Failed to enable TCP_NODELAY with error code " + std::to_string(getErrorCode()));
		return false;
	}
	else
		return true;
}

void Socket::showSSLError(int err){
	// if(err == SSL_ERROR_NONE)
	// 	LOG_INFO("SSL error: SSL_ERROR_NONE");
	// else if(err == SSL_ERROR_ZERO_RETURN)
	// 	LOG_INFO("SSL error: SSL_ERROR_ZERO_RETURN");
	// else if(err == SSL_ERROR_WANT_READ)
	// 	LOG_INFO("SSL error: SSL_ERROR_WANT_READ");
	// else if(err == SSL_ERROR_WANT_WRITE)
	// 	LOG_INFO("SSL error: SSL_ERROR_WANT_WRITE");
	// else if(err == SSL_ERROR_WANT_CONNECT)
	// 	LOG_INFO("SSL error: SSL_ERROR_WANT_CONNECT");
	// else if(err == SSL_ERROR_WANT_ACCEPT)
	// 	LOG_INFO("SSL error: SSL_ERROR_WANT_ACCEPT");
	// else if(err == SSL_ERROR_WANT_X509_LOOKUP)
	// 	LOG_INFO("SSL error: SSL_ERROR_WANT_X509_LOOKUP");
	// else if(err == SSL_ERROR_SYSCALL)
	// 	LOG_INFO("ssl error: SSL_ERROR_SYSCALL");
	// else if(err == SSL_ERROR_SSL)
	// 	LOG_ERR("SSL error: SSL_ERROR_SSL");
	// else
	// 	LOG_ERR("Unknown SSL error:" + std::to_string(err));
}

int Socket::getErrorCode(){
#ifdef WINDOWS
	return WSAGetLastError();
#else
	return errno;
#endif
}



DataInputStream::DataInputStream(STREAM_TYPE type, int bufSize) : file_(0), buf_(new char[bufSize]), source_(type), reverseOrder_(false), externalBuf_(false),
		closed_(false), capacity_(bufSize), size_(0), cursor_(0){
}

DataInputStream::DataInputStream(const SocketSP& socket, int bufSize) : socket_(socket), file_(0), buf_(new char[bufSize]), source_(SOCKET_STREAM), reverseOrder_(false),
		externalBuf_(false), closed_(false), capacity_(bufSize), size_(0), cursor_(0){
}

DataInputStream::DataInputStream(FILE* file, int bufSize) : file_(file), buf_(new char[bufSize]), source_(FILE_STREAM), reverseOrder_(false), externalBuf_(false),
		closed_(false), capacity_(bufSize), size_(0), cursor_(0){
}

DataInputStream::DataInputStream(const char* data, int size, bool copy) : file_(0), source_(ARRAY_STREAM), reverseOrder_(false), externalBuf_(!copy), closed_(false),
		capacity_(size), size_(size), cursor_(0){
	if(copy){
		buf_ = new char[size];
		memcpy(buf_, data, size);
	}
	else{
		buf_ = (char*)data;
	}
}

DataInputStream::~DataInputStream(){
	if(!externalBuf_)
		delete[] buf_;
	if(source_ == FILE_STREAM)
		close();
}

IO_ERR DataInputStream::internalStreamRead(char* buf, size_t length, size_t& actualLength){
	// throw RuntimeException("DataInputStream::internalStreamRead not implemented yet.");
}

IO_ERR DataInputStream::internalClose(){
	// throw RuntimeException("DataInputStream::internalStreamRead not implemented yet.");
}

bool DataInputStream::reset(int size){
	if(!externalBuf_)
		return false;
	else{
		cursor_ = 0;
		capacity_ = size;
		size_ = size;
		return true;
	}
}

long long DataInputStream::getPosition() const {
	if(source_ == FILE_STREAM && file_ != NULL){
		long long lastPos = ftello64(file_);
		if(lastPos < 0)
			return -1;
		else
			return lastPos - size_;
	}
	else
		return cursor_;
}

bool DataInputStream::moveToPosition(long long offset){
	if(source_ == FILE_STREAM){
		if(fseeko64(file_, offset, SEEK_SET) == 0){
			cursor_ = 0;
			size_ = 0;
			return true;
		}
		else
			return false;
	}
	else if(source_ > FILE_STREAM){
		bool ret = internalMoveToPosition(offset);
		if(ret){
			cursor_ = 0;
			size_ = 0;
		}
		return ret;
	}
	else
		return false;
}

IO_ERR DataInputStream::readBool(bool& value){
	return readBytes((char*)&value, 1, false);
}

IO_ERR DataInputStream::readBool(char& value){
	return readBytes(&value, 1, false);
}

IO_ERR DataInputStream::readChar(char& value){
	return readBytes(&value, 1, false);
}

IO_ERR DataInputStream::readUnsignedChar(unsigned char& value){
	return readBytes((char*)(&value), 1, false);
}

IO_ERR DataInputStream::readShort(short& value){
	return readBytes((char*)(&value), 2, reverseOrder_);
}

IO_ERR DataInputStream::readUnsignedShort(unsigned short& value){
	return readBytes((char*)(&value), 2, reverseOrder_);
}

IO_ERR DataInputStream::readInt(int& value){
	return readBytes((char*)(&value), 4, reverseOrder_);
}

IO_ERR DataInputStream::readUnsignedInt(unsigned int& value){
	return readBytes((char*)(&value), 4, reverseOrder_);
}

IO_ERR DataInputStream::readLong(long long& value){
	return readBytes((char*)(&value), 8, reverseOrder_);
}

IO_ERR DataInputStream::readIndex(INDEX& value){
#ifdef INDEX64
	return readBytes((char*)(&value), 8, reverseOrder_);
#else
	return readBytes((char*)(&value), 4, reverseOrder_);
#endif
}

IO_ERR DataInputStream::readFloat(float& value){
	return readBytes((char*)(&value), 4, reverseOrder_);
}

IO_ERR DataInputStream::readDouble(double& value){
	return readBytes((char*)(&value), 8, reverseOrder_);
}

IO_ERR DataInputStream::readString(string& value){
	size_t endPos;
	IO_ERR ret = prepareBytesEndWith(0, endPos);
	if(ret != OK)
		return ret;

	size_ -= endPos - cursor_ + 1;
	size_t lineLength = endPos - cursor_;
	if(lineLength > 0 && buf_[endPos - 1] == '\r')
		lineLength--;
	value.clear();
	value.append(buf_ + cursor_, lineLength);
	cursor_ = endPos + 1;
	return OK;
}

IO_ERR DataInputStream::readString(string& value, size_t length){
	if(size_ < length){
		IO_ERR ret =prepareBytes(length);
		if(ret != OK)
			return ret;
	}

	value.clear();
	value.append(buf_+cursor_, length);
	size_ -= length;
	cursor_ += length;
	return OK;
}

IO_ERR DataInputStream::readLine(string& value){
	size_t endPos;
	IO_ERR ret = prepareBytesEndWith('\n', endPos);
	if(ret != OK)
		return ret;

	size_ -= endPos - cursor_ + 1;
	size_t lineLength = endPos - cursor_;
	if(lineLength > 0 && buf_[endPos - 1] == '\r')
		lineLength--;
	value.clear();
	value.append(buf_ + cursor_, lineLength);
	cursor_ = endPos + 1;
	return OK;
}

IO_ERR DataInputStream::peekBuffer(char* buf, size_t length){
	if(size_ < length){
		IO_ERR ret =prepareBytes(length);
		if(ret != OK)
			return ret;
	}

	memcpy(buf, buf_+cursor_, length);
	return OK;
}

IO_ERR DataInputStream::peekLine(string& value){
	size_t endPos;
	IO_ERR ret = prepareBytesEndWith('\n', endPos);
	if(ret != OK)
		return ret;

	size_t lineLength = endPos - cursor_;
	if(lineLength > 0 && buf_[endPos - 1] == '\r')
		lineLength--;
	value.clear();
	value.append(buf_ + cursor_, lineLength);
	return OK;
}

IO_ERR DataInputStream::bufferBytes(size_t length){
	if(size_ >= length)
		return OK;
	else
		return prepareBytes(length);
}

IO_ERR DataInputStream::readBytes(char* buf, size_t length, bool reverseOrder){
	if(size_ < length){
		IO_ERR ret =prepareBytes(length);
		if(ret != OK)
			return ret;
	}

	if(length == 1)
		*buf = buf_[cursor_];
	else if(reverseOrder){
		char* src = buf_ + (cursor_ + length - 1);
		size_t count = length;
		while(count){
			*buf++ = *src--;
			--count;
		}
	}
	else{
		memcpy(buf, buf_+cursor_, length);
	}
	size_ -= length;
	cursor_ += length;
	return OK;
}

IO_ERR DataInputStream::readBytes(char* buf, size_t length, size_t& actualLength){
	actualLength = 0;
    size_t count = std::min(size_, length);
    if(count){
		memcpy(buf, buf_+cursor_, count);
		actualLength += count;
		size_ -= count;
		cursor_ += count;
		if(count == length)
			return OK;
    }

    if(source_ == SOCKET_STREAM){
    	count = 0;
    	IO_ERR ret = OK;
    	while(ret == OK && actualLength < length){
    		ret = socket_->read(buf+actualLength, length-actualLength, count);
			if(ret == OK)
				actualLength += count;
    	}
    	return ret;
    }
    else if(source_ == FILE_STREAM){
    	count = fread(buf + actualLength, 1, length-actualLength, file_);
    	actualLength += count;
    	if(count == 0){
    		if(feof(file_))
    			return END_OF_STREAM;
    		else
    			return OTHERERR;
    	}
    	else
    		return OK;
    }
    else if(source_ == ARRAY_STREAM){
    	if(actualLength == 0)
    		return END_OF_STREAM;
    	else
    		return OK;
    }
    else{
    	size_t readCount;
    	IO_ERR ret = internalStreamRead(buf + actualLength, length - actualLength, readCount);
   		actualLength += readCount;
    	return ret;
    }
}

IO_ERR DataInputStream::readBytes(char* buf, size_t unitLength, size_t length, size_t& actualLength){
	if(unitLength == 1)
		return readBytes(buf, length, actualLength);
	else if(unitLength > MAX_CAPACITY)
		return TOO_LARGE_DATA;
	IO_ERR ret = readBytes(buf, length * unitLength, actualLength);
	int remainder = actualLength % unitLength;
	actualLength = actualLength / unitLength;
	if(remainder >0){
		cursor_ = 0;
		size_ = remainder;
		memcpy(buf_, buf + unitLength * actualLength, size_);
	}
	return ret;
}

IO_ERR DataInputStream::prepareBytes(size_t length){
	if(source_ == ARRAY_STREAM)
		return END_OF_STREAM;

	if(capacity_ < length){
		if(length > MAX_CAPACITY)
			return TOO_LARGE_DATA;
		char* tmp = new char[length];
		memcpy(tmp, buf_+cursor_, size_);
		capacity_ = length;
		cursor_ =0;
		delete[] buf_;
		buf_ = tmp;
	}
	else if(capacity_ - cursor_ <length || (source_ > FILE_STREAM && (cursor_ << 1) > capacity_)){
		memmove(buf_, buf_+cursor_, size_);
		cursor_ =0;
	}

	size_t actualLength;
	size_t usedSpace = cursor_ + size_;
	if(source_ == SOCKET_STREAM){
		while(size_ < length){
			IO_ERR ret = socket_->read(buf_ + usedSpace, capacity_ - usedSpace, actualLength);
			if(ret != OK)
				return ret;
			size_ += actualLength;
			usedSpace += actualLength;
		}
		return OK;
	}
	else if(source_ == FILE_STREAM){
		size_t num = capacity_ - usedSpace;
		actualLength = fread(buf_ + usedSpace, 1, num, file_);
		size_ += actualLength;
		if(actualLength == num)
			return OK;
		else if(feof(file_)){
			if(size_ >= length)
				return OK;
			else
				return END_OF_STREAM;
		}
		else
			return OTHERERR;
	}
	else{
		IO_ERR ret  = internalStreamRead(buf_ + usedSpace, capacity_ - usedSpace, actualLength);
		size_ += actualLength;
		if(size_ < length){
			return END_OF_STREAM;
		}
		else
			return ret;
	}
}

IO_ERR DataInputStream::prepareBytesEndWith(char endChar, size_t& endPos){
	size_t searchedSize = 0;
	bool found = false;

	while(!found){
		char* cur = buf_ + cursor_ + searchedSize;
		int count = size_ - searchedSize;
		while(count && *cur != endChar){
			--count;
			++cur;
		}
		if(count >0){
			endPos = cur - buf_;
			found = true;
		}
		else{
			if(source_ == ARRAY_STREAM)
				return END_OF_STREAM;

			searchedSize = size_;

			if(capacity_ - size_ - cursor_ >= 1024){
			}
			else if( cursor_ >= 1024){
				//remove used data
				memmove(buf_, buf_+cursor_, size_);
				cursor_ =0;
			}
			else if(size_ >= MAX_CAPACITY)
				return TOO_LARGE_DATA;
			else {
				//increase capacity
				capacity_ = std::min(2 * capacity_, (size_t)MAX_CAPACITY);
				char* tmp = new char[capacity_];
				memcpy(tmp, buf_ + cursor_, size_);
				delete[] buf_;
				buf_ = tmp;
				cursor_ = 0;
			}

			size_t actualLength;
			size_t usedSpace = cursor_ + size_;
			if(source_ == SOCKET_STREAM){
				IO_ERR ret = socket_->read(buf_ + usedSpace, capacity_ - usedSpace, actualLength);
				if( ret != OK)
					return ret;
				size_ += actualLength;
				usedSpace += actualLength;
			}
			else if(source_ == FILE_STREAM){
				actualLength = fread(buf_ + usedSpace, 1, capacity_ - usedSpace, file_);
				if(actualLength == 0){
					if(feof(file_))
						return END_OF_STREAM;
					else
						return OTHERERR;
				}
				size_ += actualLength;
			}
			else{
				IO_ERR ret  = internalStreamRead(buf_ + usedSpace, capacity_ - usedSpace, actualLength);
				size_ += actualLength;
				if( ret != OK)
					return ret;
			}
		}
	}
	return OK;
}

IO_ERR DataInputStream::close(){
	if(closed_ || source_ == ARRAY_STREAM)
		return OK;

	if(source_ == SOCKET_STREAM){
		IO_ERR ret = socket_->close();
		if(ret == OK)
			closed_ = true;
		return ret;
	}
	else if(source_ == FILE_STREAM && file_ != NULL){
		if(fclose(file_) == 0){
			file_ = NULL;
			closed_ = true;
			return OK;
		}
		else
			return OTHERERR;
	}
	else {
		IO_ERR ret  = internalClose();
		if(ret == OK)
			closed_ = true;
		return ret;
	}
}

IO_ERR Buffer::write(const char* buffer, int length, int& actualLength){
	actualLength = 0;
	if(size_ + length > capacity_){
		if(external_ || capacity_ >= MAX_ARRAY_BUFFER)
			return TOO_LARGE_DATA;
		char* tmp = buf_;
		size_t newCapacity = std::max(size_ + length, 2 * capacity_);
		buf_ = new char[newCapacity];
		capacity_ = newCapacity;
		memcpy(buf_, tmp, size_);
		delete[] tmp;
	}
	memcpy(buf_+size_, buffer, length);
	size_ += length;
	actualLength = length;
	return OK;
}

IO_ERR Buffer::write(const char* buffer, int length){
	if(size_ + length > capacity_){
		if(external_ || capacity_ >= MAX_ARRAY_BUFFER)
			return TOO_LARGE_DATA;
		char* tmp = buf_;
		size_t newCapacity = std::max(size_ + length, 2 * capacity_);
		buf_ = new char[newCapacity];
		capacity_ = newCapacity;
		memcpy(buf_, tmp, size_);
		delete[] tmp;
	}
	memcpy(buf_+size_, buffer, length);
	size_ += length;
	return OK;
}

void Buffer::clear() {
	size_ = 0;
}



#endif
