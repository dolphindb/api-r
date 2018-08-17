#ifndef _SCALARR_H_
#define _SCALARR_H_

/*********************************************
 *
 * @Author -- Jingtang Zhang
 * @Date   -- 2018.7.14, Hangzhou
 * @Update -- 2018.8.17, Hangzhou
 * 
 *********************************************/

#include <iostream>
#include <sstream>
#include <string>
using std::string;
using std::cout;
using std::endl;

#include "Socket/SysIO.h"
#include "R_Type.h"
#include "Utill.h"

/******************************************************************
 *
 * @Description
 * 
 *  Basic class of SCALAR
 *  
 *  Store basic information of a scalar except the value.
 *  CANNOT be instancial
 * 
 *  Function 'getValue()' need to be overrided by extending class
 * 
 *  R only support
 *      bool int double string(char)
 *      [NA] need to be implemented independently
 *
 ******************************************************************/
class Scalarr 
{
private: 
    bool is_null;
public:
    Scalarr()
    {
        is_null = false;
    }
    virtual ~Scalarr() {};
    virtual void* getValue() = 0;
    void SetNull() {is_null = true;}
    bool IsNull() {return is_null;}
};

class ScalarBool : public Scalarr 
{
private:
    bool value;
public:
    ScalarBool(DataInputStream& in)
        :Scalarr()
    {
        char temp;
        in.readChar(temp);
        if (temp == (char) DDB_NULL_BYTE)
        {
            Scalarr::SetNull();
        }
        value = (bool) temp;
    }
    ScalarBool(bool in) {value = in;}
    ~ScalarBool() {}

    void* getValue() {return (void *)(&value);}
};

class ScalarChar : public Scalarr
{
private:
    string value;
public:
    ScalarChar(DataInputStream &in)
        :Scalarr()
    {
        char temp;
        in.readChar(temp);
        if (temp == (char) DDB_NULL_BYTE)
        {
            Scalarr::SetNull();
        }
        stringstream ss;
        ss << temp;
        value = ss.str();
        ss.str("");
        ss.clear();
    }
    ~ScalarChar() {}

    void* getValue() {return (void *)(&value);}
};

class ScalarInt : public Scalarr 
{
private: 
    int value;
public: 
    ScalarInt(DataInputStream& in)
        :Scalarr()
    {
        in.readInt(value);
    }
    ScalarInt(int in) {value = in;}
    ~ScalarInt() {}
    
    void* getValue() {return (void *)(&value);}
};

class ScalarDouble : public Scalarr
{
private:
    double value;
public:
    ScalarDouble(DataInputStream& in)
        :Scalarr()
    {
        in.readDouble(value);
        if (value == DDB_NULL_NUMERIC)
        {
            Scalarr::SetNull();
        }
    }
    ScalarDouble(double in) {value = in;}
    ~ScalarDouble() {}

    void* getValue() {return (void *)(&value);}
};

class ScalarString : public Scalarr 
{
private: 
    string value;
public:
    ScalarString(DataInputStream& in)
        :Scalarr()
    {
        in.readString(value);
        if (value == "")
        {
            Scalarr::SetNull();
        }
    }
    ScalarString(string in) {value = in;}
    ~ScalarString() {}

    void* getValue() {return (void *)(&value);}
};

class ScalarLong : public Scalarr
{
private: 
    double value;
public: 
    ScalarLong(DataInputStream &in)
        :Scalarr()
    {
        long long temp;
        in.readLong(temp);
        if (temp < DDB_NULL_LONG)
        {
            Scalarr::SetNull();
        }
        value = (double) temp;
    }
    ScalarLong(long long in) {value = (double) in;}
    ~ScalarLong() {}

    void* getValue() {return (void*)(&value);}
};

class ScalarFloat : public Scalarr
{
private: 
    double value;
public: 
    ScalarFloat(DataInputStream &in)
        :Scalarr()
    {
        float temp;
        in.readFloat(temp);
        if (temp == DDB_NULL_FLOAT)
        {
            Scalarr::SetNull();
        }
        value = (double) temp;
    }
    ~ScalarFloat() {}

    void* getValue() {return (void*)(&value);}
};

class ScalarShort : public Scalarr 
{
private: 
    int value;
public: 
    ScalarShort(DataInputStream &in)
        :Scalarr()
    {
        short temp;
        in.readShort(temp);
        if (temp == DDB_NULL_SHORT)
        {
            Scalarr::SetNull();
        }
        value = (int) temp;
    }
    ~ScalarShort() {}

    void* getValue() {return (void*)(&value);}
};

class ScalarDate : public Scalarr 
{
private: 
    string value;
public: 
    ScalarDate(DataInputStream &in)
        :Scalarr()
    {
        int temp;
        in.readInt(temp);
        value = Utill::ParseDate(temp);
        if (temp == DDB_NULL_INTEGER)
        {
            Scalarr::SetNull();
        }
    }
    ~ScalarDate() {}

    void* getValue() {return (void *)(&value);}
};

class ScalarMonth : public Scalarr
{
private: 
    string value;
public: 
    ScalarMonth(DataInputStream &in)
        :Scalarr()
    {
        int temp;
        in.readInt(temp);
        value = Utill::ParseMonth(temp);
        if (temp == DDB_NULL_INTEGER)
        {
            Scalarr::SetNull();
        }
    }
    ~ScalarMonth() {}

    void* getValue() {return (void *)(&value);}
};

class ScalarDateTime : public Scalarr
{
private: 
    string value;
public: 
    ScalarDateTime(DataInputStream &in)
        :Scalarr()
    {
        int temp;
        in.readInt(temp);
        value = Utill::ParseDateTime(temp);
        if (temp == DDB_NULL_INTEGER)
        {
            Scalarr::SetNull();
        }
    }
    ~ScalarDateTime() {}

    void* getValue() {return (void *)(&value);}
};

class ScalarTime : public Scalarr
{
private:
    string value;
public:
    ScalarTime(DataInputStream &in)
        :Scalarr()
    {
        int temp;
        in.readInt(temp);
        value = Utill::ParseTime(temp);
        if (temp == DDB_NULL_INTEGER)
        {
            Scalarr::SetNull();
        }
    }
    ~ScalarTime() {}

    void* getValue() {return (void*)(&value);}
};

class ScalarMinute : public Scalarr
{
private:
    string value;
public:
    ScalarMinute(DataInputStream &in)
        :Scalarr()
    {
        int temp;
        in.readInt(temp);
        value = Utill::ParseMinute(temp);
        if (temp == DDB_NULL_INTEGER)
        {
            Scalarr::SetNull();
        }
    }
    ~ScalarMinute() {}

    void* getValue() {return (void*)(&value);}
};

class ScalarSecond : public Scalarr
{
private:
    string value;
public:
    ScalarSecond(DataInputStream &in)
        :Scalarr()
    {
        int temp;
        in.readInt(temp);
        value = Utill::ParseSecond(temp);
        if (temp == DDB_NULL_INTEGER)
        {
            Scalarr::SetNull();
        }
    }
    ~ScalarSecond() {}

    void* getValue() {return (void*)(&value);}
};

class ScalarTimestamp : public Scalarr
{
private:
    string value;
public:
    ScalarTimestamp(DataInputStream &in)
        :Scalarr()
    {
        long long temp;
        in.readLong(temp);
        value = Utill::ParseTimestamp(temp);
        if (temp < DDB_NULL_LONG)
        {
            Scalarr::SetNull();
        }
    }
    ~ScalarTimestamp() {}

    void* getValue() {return (void *)(&value);}
};

class ScalarNanotime : public Scalarr 
{
private:
    string value;
public:
    ScalarNanotime(DataInputStream &in)
        :Scalarr()
    {
        long long temp;
        in.readLong(temp);
        value = Utill::ParseNanotime(temp);
        if (temp < DDB_NULL_LONG)
        {
            Scalarr::SetNull();
        }
    }
    ~ScalarNanotime() {}

    void* getValue() {return (void *)(&value);}
};

class ScalarNanotimestamp : public Scalarr
{
private:
    string value;
public:
    ScalarNanotimestamp(DataInputStream &in)
        :Scalarr()
    {
        long long temp;
        in.readLong(temp);
        value = Utill::ParseNanotimestamp(temp);
        if (temp < DDB_NULL_LONG)
        {
            Scalarr::SetNull();
        }
    }
    ~ScalarNanotimestamp() {}

    void* getValue() {return (void *)(&value);}
};

void CreateScalar(Scalarr*& scalar_ptr, int data_type, DataInputStream& in)
{
    switch(data_type)
    {
        case DATA_TYPE::DT_BOOL:
            scalar_ptr = new ScalarBool(in);
            break;
        case DATA_TYPE::DT_INT:
            scalar_ptr = new ScalarInt(in);
            break;
        case DATA_TYPE::DT_DOUBLE:
            scalar_ptr = new ScalarDouble(in);
            break;
        case DATA_TYPE::DT_CHAR:
            scalar_ptr = new ScalarChar(in);
            break;
        case DATA_TYPE::DT_STRING:
            scalar_ptr = new ScalarString(in);
            break;
        case DATA_TYPE::DT_SYMBOL:
            scalar_ptr = new ScalarString(in);
            break;
        case DATA_TYPE::DT_LONG:
            scalar_ptr = new ScalarLong(in);
            break;
        case DATA_TYPE::DT_FLOAT: 
            scalar_ptr = new ScalarFloat(in);
            break;
        case DATA_TYPE::DT_SHORT: 
            scalar_ptr = new ScalarShort(in);
            break;
        case DATA_TYPE::DT_DATE: 
            scalar_ptr = new ScalarDate(in);
            break;
        case DATA_TYPE::DT_MONTH:
            scalar_ptr = new ScalarMonth(in);
            break;
        case DATA_TYPE::DT_DATETIME: 
            scalar_ptr = new ScalarDateTime(in);
            break;
        case DATA_TYPE::DT_TIME:
            scalar_ptr = new ScalarTime(in);
            break;
        case DATA_TYPE::DT_MINUTE:
            scalar_ptr = new ScalarMinute(in);
            break;
        case DATA_TYPE::DT_SECOND:
            scalar_ptr = new ScalarSecond(in);
            break;
        case DATA_TYPE::DT_TIMESTAMP:
            scalar_ptr = new ScalarTimestamp(in);
            break;
        case DATA_TYPE::DT_NANOTIME:
            scalar_ptr = new ScalarNanotime(in);
            break;
        case DATA_TYPE::DT_NANOTIMESTAMP:
            scalar_ptr = new ScalarNanotimestamp(in);
            break;
        case DATA_TYPE::DT_VOID: 
            bool temp;
            in.readBool(temp);
            break;
        default:
            // cout << "DATA FORM UNSURPORT" << endl;
            break;
    }
}

#endif