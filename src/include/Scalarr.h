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
    int value;
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
        value = temp;
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
    Rcpp::NumericVector _vec;
public: 
    ScalarDate(DataInputStream &in)
        :Scalarr()
    {
        Rcpp::DateVector vec(1);
        int temp, y, m, d;
        in.readInt(temp);
        Utill::ParseDate(temp, y, m, d);
        vec[0] = Date(y, m, d);
        if (temp == DDB_NULL_INTEGER)
        {
            Scalarr::SetNull();
        }
        _vec = vec;
    }
    ~ScalarDate() {}

    void* getValue() {return (void *)(_vec);}
};

class ScalarMonth : public Scalarr
{
private: 
    Rcpp::NumericVector _vec;
public: 
    ScalarMonth(DataInputStream &in)
        :Scalarr()
    {
        Rcpp::DateVector vec(1);
        int temp, y, m, d;
        in.readInt(temp);
        Utill::ParseMonth(temp, y, m, d);
        vec[0] = Date(y, m, d);
        if (temp == DDB_NULL_INTEGER)
        {
            Scalarr::SetNull();
        }
        _vec = vec;
    }
    ~ScalarMonth() {}

    void* getValue() {return (void *)(_vec);}
};

class ScalarDateTime : public Scalarr
{
private: 
    Rcpp::NumericVector vec;
public: 
    ScalarDateTime(DataInputStream &in)
        :Scalarr()
    {
        vec = Rcpp::NumericVector(1);
        vec.attr("class") = Rcpp::CharacterVector::create("POSIXct", "POSIXt");
        vec.attr("tzone") = std::string("UTC");
        int temp;
        in.readInt(temp);
        vec[0] = ((double)temp);
        if (temp == DDB_NULL_INTEGER)
        {
            Scalarr::SetNull();
        }
    }
    ~ScalarDateTime() {}

    void* getValue() {return (void *)(vec);}
};

class ScalarTime : public Scalarr
{
private:
    Rcpp::NumericVector vec;
public:
    ScalarTime(DataInputStream &in)
        :Scalarr()
    {
        vec = Rcpp::NumericVector(1);
        vec.attr("class") = Rcpp::CharacterVector::create("POSIXct", "POSIXt");
        vec.attr("tzone") = std::string("UTC");
        int temp;
        in.readInt(temp);
        vec[0] = ((double)temp)/1000;
        if (temp == DDB_NULL_INTEGER)
        {
            Scalarr::SetNull();
        }
    }
    ~ScalarTime() {}

    void* getValue() {return (void*)(vec);}
};

class ScalarMinute : public Scalarr
{
private:
    Rcpp::NumericVector vec;
public:
    ScalarMinute(DataInputStream &in)
        :Scalarr()
    {
        vec = Rcpp::NumericVector(1);
        vec.attr("class") = Rcpp::CharacterVector::create("POSIXct", "POSIXt");
        vec.attr("tzone") = std::string("UTC");
        int temp;
        in.readInt(temp);
        vec[0] = (double)(temp*60);
        if (temp == DDB_NULL_INTEGER)
        {
            Scalarr::SetNull();
        }
    }
    ~ScalarMinute() {}

    void* getValue() {return (void*)(vec);}
};

class ScalarSecond : public Scalarr
{
private:
    Rcpp::NumericVector vec;
public:
    ScalarSecond(DataInputStream &in)
        :Scalarr()
    {
        vec = Rcpp::NumericVector(1);
        vec.attr("class") = Rcpp::CharacterVector::create("POSIXct", "POSIXt");
        vec.attr("tzone") = std::string("UTC");
        int temp;
        in.readInt(temp);
        vec[0] = ((double)temp);
        if (temp == DDB_NULL_INTEGER)
        {
            Scalarr::SetNull();
        }
    }
    ~ScalarSecond() {}

    void* getValue() {return (void*)(vec);}
};

class ScalarTimestamp : public Scalarr
{
private:
    Rcpp::NumericVector vec;
public:
    ScalarTimestamp(DataInputStream &in)
        :Scalarr()
    {
        vec = Rcpp::NumericVector(1);
        vec.attr("class") = Rcpp::CharacterVector::create("POSIXct", "POSIXt");
        vec.attr("tzone") = std::string("UTC");
        long long temp;
        in.readLong(temp);
        vec[0] = ((double)temp)/1000;
        if (temp < DDB_NULL_LONG)
        {
            Scalarr::SetNull();
        }
    }
    ~ScalarTimestamp() {}

    void* getValue() {return (void *)(vec);}
};

class ScalarNanotime : public Scalarr 
{
private:
    Rcpp::NumericVector vec;
public:
    ScalarNanotime(DataInputStream &in)
        :Scalarr()
    {
        vec = Rcpp::NumericVector(1);
        vec.attr("class") = Rcpp::CharacterVector::create("POSIXct", "POSIXt");
        vec.attr("tzone") = std::string("UTC");
        long long temp;
        in.readLong(temp);
        vec[0] = ((double)temp)/1000000000L;
        if (temp < DDB_NULL_LONG)
        {
            Scalarr::SetNull();
        }
    }
    ~ScalarNanotime() {}

    void* getValue() {return (void *)(vec);}
};

class ScalarNanotimestamp : public Scalarr
{
private:
    Rcpp::NumericVector vec;
public:
    ScalarNanotimestamp(DataInputStream &in)
        :Scalarr()
    {
        vec = Rcpp::NumericVector(1);
        vec.attr("class") = Rcpp::CharacterVector::create("POSIXct", "POSIXt");
        vec.attr("tzone") = std::string("UTC");
        long long temp;
        in.readLong(temp);
        vec[0] = ((double)temp)/1000000000L;
        if (temp < DDB_NULL_LONG)
        {
            Scalarr::SetNull();
        }
    }
    ~ScalarNanotimestamp() {}

    void* getValue() {return (void *)(vec);}
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