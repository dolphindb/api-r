#ifndef _RCPP_CONNECTOR_H_
#define _RCPP_CONNECTOR_H_

/**************************************************
 *
 * @Author -- Jingtang Zhang
 * @Date   -- 2018.7.12, Hangzhou
 * @Update -- 2018.8.1, Hangzhou
 * 
 **************************************************/

/**************************************************
 *
 * @Description
 *  
 *  Store the entity from server in different
 *  forms and types.
 *  Provide functions for R to return data in
 *  different forms and types.
 *  Provide functions for R to upload data in
 *  different forms and types.
 * 
 * 
 **************************************************/

#include <string>
#include <sstream>
#include <string.h>

#include "Socket/SysIO.h"
#include "Entity.h"
#include "R_Type.h"

using std::stringstream;
using std::vector;
using std::set;
using std::cout;
using std::endl;

class Rcpp_Connector
{
private:
    SocketSP socket;
    DataInputStreamSP in;
    string sessionID;
    bool remoteLittleEndian;
    bool connected;

    Entity* entity;
    
public:
    Rcpp_Connector()
        : sessionID(""), remoteLittleEndian(false), connected(false)
    {
        socket = new Socket();
    }
    ~Rcpp_Connector()
    {
        if (entity != NULL)
        {
            delete entity;
            entity = NULL;
        }
        // in -> close();
        // socket -> close();
    }

    bool Rcpp_Connect(string host, int port);
    void Rcpp_DisConnect();

    void Rcpp_ClearEntity();
    Entity* Rcpp_GetEntity() {return entity;}
    int Rcpp_ReceiveEntity();
    bool Rcpp_ReceiveHeader();

    int Rcpp_ReturnRType(int data_form, int data_type);

    bool Rcpp_RunScriptInit(string script);
    bool Rcpp_RunFunctionInit(string func, int arg_size);
    bool Rcpp_RunUploadInit(vector <string>& keys);

    void Rcpp_UploadEmptyScalar();
    void Rcpp_UploadEmptyVector(int row, int clm);
    void Rcpp_UploadEmptyMatrix(int row, int clm);
    void Rcpp_UploadDateScalar(string date_str);
    void Rcpp_UploadDateVector(vector <string>& vec, vector <int>& NAIndex);
    void Rcpp_UploadDateTimeScalar(string data_time_str);
    void Rcpp_UploadDateTimeVector(vector <string>& vec, vector <int>& NAIndex);
    void Rcpp_UploadEntity(int val);
    void Rcpp_UploadEntity(double val);
    void Rcpp_UploadEntity(char val);
    void Rcpp_UploadEntity(string val);
    void Rcpp_UploadEntity(vector <int>& vec, vector <int>& NAIndex);
    void Rcpp_UploadEntity(vector <bool>& vec, vector <int>& NAIndex);
    void Rcpp_UploadEntity(vector <double>& vec, vector <int>& NAIndex);
    void Rcpp_UploadEntity(vector <string>& vec, vector <int>& NAIndex);
    void Rcpp_UploadMatrixLableFlag(int flag);
    void Rcpp_UploadMatrixBasic(int type);
    void Rcpp_UploadTableBasic(int row, int clm, vector <string>& colnames);
    void Rcpp_UploadEntity(vector <bool>& mtx, vector <int>& NAIndex, int row, int clm);
    void Rcpp_UploadEntity(vector <int>& mtx, vector <int>& NAIndex, int row, int clm);
    void Rcpp_UploadEntity(vector <double>& mtx, vector <int>& NAIndex, int row, int clm);
};

void Rcpp_Connector::Rcpp_UploadDateVector(vector <string>& vec, vector <int>& NAIndex)
{
    for (unsigned int i = 0; i < NAIndex.size(); i++)
    {
        vec[NAIndex[i]] = "";
    }

    vector <int> upload_date;
    upload_date.reserve(vec.size());
    for (unsigned int i = 0; i < vec.size(); i++) 
    {
        if (vec[i] == "")
        {
            upload_date.push_back(DDB_NULL_INTEGER);
        }
        else
        {
            upload_date.push_back(Utill::CountDays(vec[i]));
        }
    }

    Buffer buffer;
    int flag = (DATA_FORM::DF_VECTOR << 8) + DATA_TYPE::DT_DATE;
    buffer.write((short) flag);
    buffer.write((int) upload_date.size());
    buffer.write((int) 1);
    for (unsigned int i = 0; i < upload_date.size(); i++)
    {
        buffer.write(upload_date[i]);
    }

    size_t actual = 0;
    socket->write(buffer.getBuffer(), buffer.size(), actual);
}

void Rcpp_Connector::Rcpp_UploadDateTimeVector(vector <string>& vec, vector <int>& NAIndex)
{
    for (unsigned int i = 0; i < NAIndex.size(); i++)
    {
        vec[NAIndex[i]] = "";
    }

    vector <int> upload_date_time;
    upload_date_time.reserve(vec.size());
    for (unsigned int i = 0; i < vec.size(); i++)
    {
        if (vec[i] == "")
        {
            upload_date_time.push_back(DDB_NULL_INTEGER);
        }
        else 
        {
            upload_date_time.push_back(Utill::CountSeconds(vec[i]));
        }
    }

    Buffer buffer;
    int flag = (DATA_FORM::DF_VECTOR << 8) + DATA_TYPE::DT_DATETIME;
    buffer.write((short) flag);
    buffer.write((int) upload_date_time.size());
    buffer.write((int) 1);
    for (unsigned int i = 0; i < upload_date_time.size(); i++)
    {
        buffer.write(upload_date_time[i]);
    }

    size_t actual = 0;
    socket->write(buffer.getBuffer(), buffer.size(), actual);
}

void Rcpp_Connector::Rcpp_UploadDateTimeScalar(string date_time_str)
{
    Buffer buffer;
    int flag = (DATA_FORM::DF_SCALAR << 8) + DATA_TYPE::DT_DATETIME;
    buffer.write((short) flag);
    buffer.write(Utill::CountSeconds(date_time_str));

    size_t actual = 0;
    socket->write(buffer.getBuffer(), buffer.size(), actual);
}

void Rcpp_Connector::Rcpp_UploadDateScalar(string date_str)
{
    Buffer buffer;
    int flag = (DATA_FORM::DF_SCALAR << 8) + DATA_TYPE::DT_DATE;
    buffer.write((short) flag);
    buffer.write(Utill::CountDays(date_str));

    size_t actual = 0;
    socket->write(buffer.getBuffer(), buffer.size(), actual);
}

void Rcpp_Connector::Rcpp_UploadTableBasic(int row, int clm, vector <string>& colnames)
{
    int flag = (DATA_FORM::DF_TABLE << 8) + DATA_TYPE::DT_DICTIONARY;
    Buffer buffer;
    buffer.write((short) flag);
    buffer.write(row);
    buffer.write(clm);
    
    string str("");
    buffer.write(str);
    for (unsigned int i = 0; i < colnames.size(); i++)
    {
        buffer.write(colnames[i]);
    }

    size_t actual = 0;
    socket->write(buffer.getBuffer(), buffer.size(), actual);
}

void Rcpp_Connector::Rcpp_UploadEmptyMatrix(int row, int clm)
{
    Buffer buffer;
    buffer.write(row);
    buffer.write(clm);
    for (int i = 0; i < row*clm; i++)
    {
        buffer.write((double) DDB_NULL_NUMERIC);
    }

    size_t actual = 0;
    socket->write(buffer.getBuffer(), buffer.size(), actual);
}

void Rcpp_Connector::Rcpp_UploadEntity(vector <double>& mtx, vector <int>& NAIndex, int row, int clm)
{
    for (unsigned int i = 0; i < NAIndex.size(); i++)
    {
        mtx[NAIndex[i]] = DDB_NULL_NUMERIC;
    }

    Buffer buffer;
    buffer.write(row);
    buffer.write(clm);
    for (unsigned int i = 0; i < mtx.size(); i++)
    {
        buffer.write(mtx[i]);
    }

    size_t actual = 0;
    socket->write(buffer.getBuffer(), buffer.size(), actual);
}

void Rcpp_Connector::Rcpp_UploadEntity(vector <int>& mtx, vector <int>& NAIndex, int row, int clm)
{
    for (unsigned int i = 0; i < NAIndex.size(); i++)
    {
        mtx[NAIndex[i]] = DDB_NULL_INTEGER;
    }

    Buffer buffer;
    buffer.write(row);
    buffer.write(clm);
    for (unsigned int i = 0; i < mtx.size(); i++)
    {
        buffer.write(mtx[i]);
    }

    size_t actual = 0;
    socket->write(buffer.getBuffer(), buffer.size(), actual);
}

void Rcpp_Connector::Rcpp_UploadEntity(vector <bool>& mtx, vector <int>& NAIndex, int row, int clm)
{
    vector <char> convert;
    convert.reserve(mtx.size());
    for (unsigned int i = 0; i < mtx.size(); i++)
    {
        convert.push_back((char) mtx[i]);
    }
    for (unsigned int i = 0; i < NAIndex.size(); i++)
    {
        convert[NAIndex[i]] = DDB_NULL_LOGICAL;
    }

    Buffer buffer;
    buffer.write(row);
    buffer.write(clm);
    for (unsigned int i = 0; i < convert.size(); i++)
    {
        buffer.write(convert[i]);
    }

    size_t actual = 0;
    socket->write(buffer.getBuffer(), buffer.size(), actual);
}

void Rcpp_Connector::Rcpp_UploadMatrixLableFlag(int flag)
{
    Buffer buffer;
    buffer.write((char) flag);

    size_t actual = 0;
    socket->write(buffer.getBuffer(), buffer.size(), actual);
}

void Rcpp_Connector::Rcpp_UploadMatrixBasic(int type)
{
    int flag;
    switch(type) {
        case DATA_TYPE::DT_INT: 
            flag = (DATA_FORM::DF_MATRIX << 8) + DATA_TYPE::DT_INT;
            break;
        case DATA_TYPE::DT_DOUBLE: 
            flag = (DATA_FORM::DF_MATRIX << 8) + DATA_TYPE::DT_DOUBLE;
            break;
        default:
            flag = (DATA_FORM::DF_MATRIX << 8) + DATA_TYPE::DT_BOOL;
            break;
    }
    Buffer buffer;
    buffer.write((short) flag);
    
    size_t actual = 0;
    socket->write(buffer.getBuffer(), buffer.size(), actual);
}

void Rcpp_Connector::Rcpp_UploadEntity(vector <string>& vec, vector <int>& NAIndex)
{
    for (unsigned int i = 0; i < NAIndex.size(); i++)
    {
        vec[NAIndex[i]] = "";
    }

    Buffer buffer;
    int flag = (DATA_FORM::DF_VECTOR << 8) + DATA_TYPE::DT_STRING;
    buffer.write((short) flag);
    buffer.write((int) vec.size());
    buffer.write((int) 1);
    for (unsigned int i = 0; i < vec.size(); i++)
    {
        buffer.write(vec[i]);
    }

    size_t actual = 0;
    socket->write(buffer.getBuffer(), buffer.size(), actual);
}

void Rcpp_Connector::Rcpp_UploadEntity(vector <double>& vec, vector <int>& NAIndex)
{
    for (unsigned int i = 0; i < NAIndex.size(); i++)
    {
        vec[NAIndex[i]] = DDB_NULL_NUMERIC;
    }

    Buffer buffer;
    int flag = (DATA_FORM::DF_VECTOR << 8) + DATA_TYPE::DT_DOUBLE;
    buffer.write((short) flag);
    buffer.write((int) vec.size());
    buffer.write((int) 1);
    for (unsigned int i = 0; i < vec.size(); i++)
    {
        buffer.write(vec[i]);
    }

    size_t actual = 0;
    socket->write(buffer.getBuffer(), buffer.size(), actual);
}

void Rcpp_Connector::Rcpp_UploadEntity(vector <bool>& vec, vector <int>& NAIndex)
{
    vector <char> convert;
    convert.reserve(vec.size());
    for (unsigned int i = 0; i < vec.size(); i++)
    {
        convert.push_back((char) vec[i]);
    }
    for (unsigned int i = 0; i < NAIndex.size(); i++)
    {
        convert[NAIndex[i]] = DDB_NULL_LOGICAL;
    }

    Buffer buffer;
    int flag = (DATA_FORM::DF_VECTOR << 8) + DATA_TYPE::DT_BOOL;
    buffer.write((short) flag);
    buffer.write((int) convert.size());
    buffer.write((int) 1);
    for (unsigned int i = 0; i < convert.size(); i++)
    {
        buffer.write(convert[i]);
    }

    size_t actual = 0;
    socket->write(buffer.getBuffer(), buffer.size(), actual);
}

void Rcpp_Connector::Rcpp_UploadEntity(vector <int>& vec, vector <int>& NAIndex)
{
    for (unsigned int i = 0; i < NAIndex.size(); i++)
    {
        vec[NAIndex[i]] = DDB_NULL_INTEGER;
    }

    Buffer buffer;
    int flag = (DATA_FORM::DF_VECTOR << 8) + DATA_TYPE::DT_INT;
    buffer.write((short) flag);
    buffer.write((int) vec.size());
    buffer.write((int) 1);
    for (unsigned int i = 0; i < vec.size(); i++)
    {
        buffer.write(vec[i]);
    }

    size_t actual = 0;
    socket->write(buffer.getBuffer(), buffer.size(), actual);
}

void Rcpp_Connector::Rcpp_UploadEmptyVector(int row, int clm)
{
    Buffer buffer;
    int flag = (DATA_FORM::DF_VECTOR << 8) + DATA_TYPE::DT_DOUBLE;
    buffer.write((short) flag);
    buffer.write(row);
    buffer.write(clm);
    for (int i = 0; i < row*clm; i++)
    {
        buffer.write((double) DDB_NULL_NUMERIC);
    }

    size_t actual = 0;
    socket->write(buffer.getBuffer(), buffer.size(), actual);
}

void Rcpp_Connector::Rcpp_UploadEntity(string val)
{
    Buffer buffer;
    int flag = (DATA_FORM::DF_SCALAR << 8) + DATA_TYPE::DT_STRING;
    buffer.write((short) flag);
    buffer.write(val);

    size_t actual = 0;
    socket->write(buffer.getBuffer(), buffer.size(), actual);
}

void Rcpp_Connector::Rcpp_UploadEntity(double val)
{
    Buffer buffer;
    int flag = (DATA_FORM::DF_SCALAR << 8) + DATA_TYPE::DT_DOUBLE;
    buffer.write((short) flag);
    buffer.write(val);

    size_t actual = 0;
    socket->write(buffer.getBuffer(), buffer.size(), actual);
}

void Rcpp_Connector::Rcpp_UploadEntity(char val)
{
    Buffer buffer;
    int flag = (DATA_FORM::DF_SCALAR << 8) + DATA_TYPE::DT_BOOL;
    buffer.write((short) flag);
    buffer.write(val);

    size_t actual = 0;
    socket->write(buffer.getBuffer(), buffer.size(), actual);
}

void Rcpp_Connector::Rcpp_UploadEmptyScalar()
{
    Buffer buffer;
    int flag = (DATA_FORM::DF_SCALAR << 8) + DATA_TYPE::DT_VOID;
    buffer.write((short) flag);
    buffer.write(true);

    size_t actual = 0;
    socket->write(buffer.getBuffer(), buffer.size(), actual);
}

void Rcpp_Connector::Rcpp_UploadEntity(int val)
{
    Buffer buffer;
    int flag = (DATA_FORM::DF_SCALAR << 8) + DATA_TYPE::DT_INT;
    buffer.write((short) flag);
    buffer.write(val);

    size_t actual = 0;
    socket->write(buffer.getBuffer(), buffer.size(), actual);
}

bool Rcpp_Connector::Rcpp_RunUploadInit(vector <string>& keys)
{
    string body = "variable\n";
    for (unsigned int i = 0; i < keys.size(); i++)
    {
        if (!Utill::IsVariableCandidate(keys[i]))
        {
            cout << "[Error] '" << keys[i] << "' is not a good variable name." << endl;
            return false;
        }
        body += keys[i];
        body += ",";
    }
    
    stringstream ss;
    ss << (int) keys.size();

    body.assign(body, 0, body.length()-1);
    body += "\n";
    body += ss.str();
    body += "\n";
    body += (remoteLittleEndian ? "1" : "0");

    ss.str("");
    ss.clear();
    ss << body.size();

    string up = "API ";
    up += sessionID;
    up += " ";
    up += ss.str();
    up += "\n";
    up += body;

    size_t actual = 0;
    socket->write(up.c_str(), up.size(), actual);

    return true;
}

bool Rcpp_Connector::Rcpp_RunFunctionInit(string func, int arg_size)
{
    if (connected == false)
    {
        cout << "[ERROR] No connection available" << endl;
        return false;
    }

    string body = "function\n" + func;
    stringstream ss;
    ss << arg_size;

    body += "\n";
    body += ss.str();
    body += "\n";
    body += (remoteLittleEndian ? "1" : "0");

    ss.str("");
    ss.clear();
    ss << body.size();

    string up = "API ";
    up += sessionID;
    up += " ";
    up += ss.str();
    up += "\n";
    up += body;
    
    size_t actual = 0;
    socket -> write(up.c_str(), up.size(), actual);

    return true;
}

bool Rcpp_Connector::Rcpp_Connect(string host, int port)
{
    // Maintain only 1 socket connection
    if (connected)
    {
        in -> close();
        socket -> close();
        connected = false;
    }

    IO_ERR status = socket -> connect(host, port, true);

    if (status != OK)
    {
        cout << "[ERROR] Connection failed" << endl;
        connected = false;
        return false;
    }
    else {
        connected = true;
        in = new DataInputStream(socket);

        string body = "connect\n";
        string up = "API 0 ";
        up += std::to_string(body.length());
        up += "\n";
        up += body;

        size_t actual = 0;
        socket -> write(up.c_str(), up.size(), actual);

        string line;
        in -> readLine(line);

        int endPos = line.find_first_of(" ", 0);
        if (endPos == string::npos)
        {
            cout << "[ERROR] Data format error" << endl;
            connected = false;
            in -> close();
            socket -> close();
            return false;
        }
        sessionID.assign(line, 0, endPos);

        int startPos = endPos + 1;
        endPos = line.find_first_of(" ", startPos);
        if (endPos != line.size() - 2)
        {
            cout << "[ERROR] Data format error" << endl;
            connected = false;
            in -> close();
            socket -> close();
            return false;
        }

        // Endian
        if (line[endPos+1] == '0')
        {
            remoteLittleEndian = false;
        }
        else
        {
            remoteLittleEndian = true;
        }

        return true;
    }
}

bool Rcpp_Connector::Rcpp_ReceiveHeader()
{
    if (remoteLittleEndian == true)
    {
        in -> disableReverseIntegerByteOrder();
    }
    else
    {
        in -> enableReverseIntegerByteOrder();
    }

    string header;
    in -> readLine(header);

    while (header == "OK")
    {
        in -> readLine(header);
    }

    // Split
    vector <string> headers;
    while (header != "")
    {
        if (header[0] == ' ')
        {
            break;
        }
        int endPos = header.find_first_of(' ', 0);
        if (endPos == string::npos)
        {
            headers.push_back(header);
            break;
        }
        string factor (header, 0, endPos);
        headers.push_back(factor);
        header.assign(header, endPos+1, header.length()-endPos-1);
    }

    if (headers.size() != 3)
    {
        cout << "[ERROR] Invalid header" << endl;
        connected = false;
        in -> close();
        socket -> close();
        return false;
    }

    stringstream ss;
    int numObject;
    ss << headers[1];
    ss >> numObject;
    ss.str("");
    ss.clear();

    string msg;
    in -> readLine(msg);

    if (msg != "OK")
    {
        cout << "[1] " << msg << endl;
        return false;
    }

    return true;
}

int Rcpp_Connector::Rcpp_ReceiveEntity()
{
    if (remoteLittleEndian == true)
    {
        in -> disableReverseIntegerByteOrder();
    }
    else
    {
        in -> enableReverseIntegerByteOrder();
    }

    string header;
    in -> readLine(header);

    while (header == "OK")
    {
        in -> readLine(header);
    }

    // Split
    vector <string> headers;
    while (header != "")
    {
        if (header[0] == ' ')
        {
            break;
        }
        int endPos = header.find_first_of(' ', 0);
        if (endPos == string::npos)
        {
            headers.push_back(header);
            break;
        }
        string factor (header, 0, endPos);
        headers.push_back(factor);
        header.assign(header, endPos+1, header.length()-endPos-1);
    }

    if (headers.size() != 3)
    {
        cout << "[ERROR] Invalid header" << endl;
        connected = false;
        in -> close();
        socket -> close();
        return ERRORR;
    }

    stringstream ss;
    int numObject;
    ss << headers[1];
    ss >> numObject;
    ss.str("");
    ss.clear();

    string msg;
    in -> readLine(msg);

    if (msg != "OK")
    {
        cout << "[1] " << msg << endl;
        return ERRORR;
    }
    
    if (numObject == 0)
    {
        // EMPTY
        return R_TYPE::VOIDD;
    }

    short flag;
    in -> readShort(flag);
    int form = flag >> 8;
    int type = flag & 0xff;

    // cout << "form:" << form << endl;
    // cout << "type:" << type << endl;

    // set data
    entity = new Entity(form, type, *in);

    if (entity != NULL)
    {
        return Rcpp_ReturnRType(form, type);
    }
    else
    {
        return ERRORR;
    }
}

bool Rcpp_Connector::Rcpp_RunScriptInit(string script)
{
    if (connected == false)
    {
        cout << "[ERROR] No connection available" << endl;
        return false;
    }

    // Upload script
    string body = "script\n" + script;
    stringstream ss;
    ss << body.size();

    string up = "API ";
    up += sessionID;
    up += " ";
    up += ss.str();
    up += "\n";
    up += body;

    size_t actual = 0;
    socket -> write(up.c_str(), up.size(), actual);

    ss.str("");
    ss.clear();

    return true;
}

void Rcpp_Connector::Rcpp_ClearEntity()
{
    if (entity != NULL)
    {
        delete entity;
        entity = NULL;
    }
}

int Rcpp_Connector::Rcpp_ReturnRType(int data_form, int data_type)
{
    if (data_form == DATA_FORM::DF_SCALAR)
    {
        switch(data_type)
        {
            case DATA_TYPE::DT_BOOL:
                return SCALAR_LOGICAL;
            case DATA_TYPE::DT_INT:
                return SCALAR_INTEGER;
            case DATA_TYPE::DT_SHORT: 
                return SCALAR_INTEGER;
            case DATA_TYPE::DT_DOUBLE:
                return SCALAR_NUMERIC;
            case DATA_TYPE::DT_LONG: 
                return SCALAR_NUMERIC;
            case DATA_TYPE::DT_STRING:
                return SCALAR_CHARACTER;
            case DATA_TYPE::DT_FLOAT:
                return SCALAR_NUMERIC;
            case DATA_TYPE::DT_DATE: 
                return SCALAR_DATE;
            case DATA_TYPE::DT_DATETIME: 
                return SCALAR_DATETIME;
            case DATA_TYPE::DT_VOID: 
                return VOIDD;
            default:
                cout << "[ERROR] Data type not support in R" << endl;
                return 0;
        }
    }
    else if (data_form == DATA_FORM::DF_VECTOR || 
             data_form == DATA_FORM::DF_SET)
    {
        switch(data_type)
        {
            case DATA_TYPE::DT_BOOL:
                return VECTOR_LOGICAL;
            case DATA_TYPE::DT_INT:
                return VECTOR_INTEGER;
            case DATA_TYPE::DT_SHORT:
                return VECTOR_INTEGER;
            case DATA_TYPE::DT_DOUBLE:
                return VECTOR_NUMERIC;
            case DATA_TYPE::DT_LONG:
                return VECTOR_NUMERIC;
            case DATA_TYPE::DT_FLOAT: 
                return VECTOR_NUMERIC;
            case DATA_TYPE::DT_STRING:
                return VECTOR_CHARACTER;
            case DATA_TYPE::DT_DATE: 
                return VECTOR_DATE;
            case DATA_TYPE::DT_DATETIME: 
                return VECTOR_DATETIME;
            default:
                cout << "[ERROR] Data type not support in R" << endl;
                return 0;
        }
    }
    else if (data_form == DATA_FORM::DF_MATRIX)
    {
        switch(data_type)
        {
            case DATA_TYPE::DT_BOOL:
                return MATRIX_LOGICAL;
            case DATA_TYPE::DT_INT: 
                return MATRIX_INTEGER;
            case DATA_TYPE::DT_SHORT: 
                return MATRIX_INTEGER;
            case DATA_TYPE::DT_DOUBLE: 
                return MATRIX_NUMERIC;
            case DATA_TYPE::DT_LONG: 
                return MATRIX_NUMERIC;
            case DATA_TYPE::DT_FLOAT: 
                return MATRIX_NUMERIC;
            case DATA_TYPE::DT_DATE: 
                return MATRIX_DATE;
            case DATA_TYPE::DT_DATETIME: 
                return MATRIX_DATETIME;
            default:
                cout << "[ERROR] Data type not support in R" << endl;
                return 0;
        }
    }
    else if (data_form == DATA_FORM::DF_TABLE)
    {
        return TABLEE;
    }
    else
    {
        cout << "[ERROR] Data form not support in R" << endl;
    }
}

void Rcpp_Connector::Rcpp_DisConnect()
{
    if (entity != NULL)
    {
        delete entity;
        entity = NULL;
    }
    if (connected)
    {
        in -> close();
        socket -> close();
        connected = false;
    }
}

#endif