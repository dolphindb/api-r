#ifndef _VECTORR_H_
#define _VECTORR_H_

/*****************************************
 *
 * @Author -- Jingtang Zhang
 * @Date   -- 2018.7.14, Hangzhou
 * @Update -- 2018.8.17, Hangzhou
 * 
 *****************************************/

#include <iostream>
#include <sstream>
#include <string>
#include <vector>
#ifndef _RCPP_H_
    #include <Rcpp.h>
#endif
using std::vector;
using std::cout;
using std::endl;

#include "Socket/SysIO.h"
#include "R_Type.h"


/******************************************************************
 *
 * @Description
 * 
 *  Basic class of VECTOR
 *  
 *  Store basic information of a vector except the value.
 *  CANNOT be instancial
 * 
 *  Function 'getVector()' need to be overrided by extending class
 * 
 *  R only support
 *      bool int double string(char)
 *      [NA] need to be implemented independently
 *
 ******************************************************************/
class Vectorr 
{
private:
    int row;
    int clm;
    vector <int> NA_INDEX;
public:
    Vectorr(DataInputStream &in)
    {
        in.readInt(row);
        in.readInt(clm);
    }
    Vectorr() {}
    virtual ~Vectorr() {}
    virtual bool isDate() { return false; }
    int getRow() {return row;}
    int getClm() {return clm;}
    vector <int>& getNAIndex() {return NA_INDEX;}

    virtual void* getVector() = 0;
    virtual void* getStringVector() {return NULL;};
};

class VectorBool : public Vectorr 
{
private:
    vector <bool> vec;
public:
    VectorBool(DataInputStream& in)
        :Vectorr(in)
    {
        int size = Vectorr::getRow() * Vectorr::getClm();
        vec.reserve(size);
        for (int i = 0; i < size; i++)
        {
            char temp{};
            in.readChar(temp);
            vec.push_back((bool) temp);
            if (temp == (char) DDB_NULL_BYTE)
            {
                Vectorr::getNAIndex().push_back(i+1);
            }
        }
    }
    ~VectorBool() {}    // Free automatically

    void* getVector() {return (void *)(&vec);}
};

class VectorInt : public Vectorr
{
private:
    vector <int> vec;
public:
    VectorInt(DataInputStream& in)
        :Vectorr(in)
    {
        int size = Vectorr::getRow() * Vectorr::getClm();
        vec.reserve(size);
        for (int i = 0; i < size; i++)
        {
            int temp;
            in.readInt(temp);
            vec.push_back(temp);
        }
    }
    ~VectorInt() {}     // Free automatically

    void* getVector() {return (void *)(&vec);}
};

class VectorDouble : public Vectorr 
{
private: 
    vector <double> vec;
public: 
    VectorDouble(DataInputStream& in)
        :Vectorr(in)
    {
        int size = Vectorr::getRow() * Vectorr::getClm();
        vec.reserve(size);
        for (int i = 0; i < size; i++)
        {
            double temp;
            in.readDouble(temp);
            vec.push_back(temp);
            if (temp == DDB_NULL_NUMERIC)
            {
                Vectorr::getNAIndex().push_back(i+1);
            }
        }
    }
    ~VectorDouble() {}      // Free automatically

    void* getVector() {return (void *)(&vec);}
};

class VectorString : public Vectorr 
{
private:
    vector <string> vec;
public: 
    VectorString(DataInputStream& in)
        :Vectorr(in)
    {
        int size = Vectorr::getRow() * Vectorr::getClm();
        vec.reserve(size);
        for (int i = 0; i < size; i++)
        {
            string temp;
            in.readString(temp);
            vec.push_back(temp);
            if (temp == "")
            {
                Vectorr::getNAIndex().push_back(i+1);
            }
        }
    }
    ~VectorString() {}      // Free automatically

    void* getVector() {return (void *)(&vec);}
};

class VectorChar : public Vectorr
{
private:
    vector <int> vec;
public:
    VectorChar(DataInputStream &in)
        :Vectorr(in)
    {
        int size = Vectorr::getRow() * Vectorr::getClm();
        vec.reserve(size);
        for (int i = 0; i < size; i++)
        {
            char temp = 0;
            in.readChar(temp);
            int v = temp;
            vec.push_back(v);
            if (temp == (char)DDB_NULL_BYTE)
            {
                Vectorr::getNAIndex().push_back(i+1);
            }
        }
    }
    ~VectorChar() {}

    void* getVector() {return (void *)(&vec);}
};

class VectorLong : public Vectorr
{
private: 
    vector <double> vec;
public: 
    VectorLong(DataInputStream& in)
        :Vectorr(in)
    {
        int size = Vectorr::getRow() * Vectorr::getClm();
        vec.reserve(size);
        for (int i = 0; i < size; i++)
        {
            long long temp;
            in.readLong(temp);
            if (temp < DDB_NULL_LONG)
            {
                Vectorr::getNAIndex().push_back(i+1);
            }
            vec.push_back((double) temp);
        }
    }
    ~VectorLong() {}

    void* getVector() {return (void *)(&vec);}
};

class VectorFloat : public Vectorr
{
private:
    vector <double> vec;
public: 
    VectorFloat(DataInputStream& in)
        :Vectorr(in)
    {
        int size = Vectorr::getRow() * Vectorr::getClm();
        vec.reserve(size);
        for (int i = 0; i < size; i++)
        {
            float temp;
            in.readFloat(temp);
            if (temp == DDB_NULL_FLOAT)
            {
                Vectorr::getNAIndex().push_back(i+1);
            }
            vec.push_back((double) temp);
        }
    }
    ~VectorFloat() {}

    void* getVector() {return (void *)(&vec);}
};

class VectorShort : public Vectorr
{
private: 
    vector <int> vec;
public: 
    VectorShort(DataInputStream &in)
        :Vectorr(in)
    {
        int size = Vectorr::getRow() * Vectorr::getClm();
        vec.reserve(size);
        for (int i = 0; i < size; i++)
        {
            short temp;
            in.readShort(temp);
            if (temp == DDB_NULL_SHORT)
            {
                Vectorr::getNAIndex().push_back(i+1);
            }
            vec.push_back((int) temp);
        }
    }
    ~VectorShort() {}

    void* getVector() {return (void *)(&vec);}
};

class VectorDate : public Vectorr 
{
private: 
    Rcpp::DateVector _vec;

    vector<string> str_vec; 
    vector<int> origin_v;
public: 
    VectorDate(DataInputStream &in)
        :Vectorr(in), _vec(0)
    {
        int size = Vectorr::getRow() * Vectorr::getClm();
        int y, m, d;
        Rcpp::DateVector vec(size);
        origin_v.reserve(size);
        for (int i = 0; i < size; i++)
        {
            int temp;
            in.readInt(temp);
            origin_v.push_back(temp);
            Utill::ParseDate(temp, y, m, d);
            vec[i] = Date(y, m, d);
            if (temp == DDB_NULL_INTEGER)
            {
                Vectorr::getNAIndex().push_back(i+1);
            }
        }
        _vec = vec;
    }
    ~VectorDate() {}
    void* getVector() {return _vec;}
    bool isDate() { return true; }
    void* getStringVector() {
        int size = Vectorr::getRow() * Vectorr::getClm();
        str_vec.reserve(size);
        for (int i = 0; i < size; i++)
        {
            int temp = origin_v[i];
            string date_str = Utill::ParseDate(temp);
            str_vec.push_back(date_str);
        }
        return (void*)&str_vec;
    }
};

class VectorMonth : public Vectorr
{
private: 
    //TODO
    Rcpp::NumericVector _vec;
    vector<string> str_vec; 
    vector<int> origin_v;
public: 
    VectorMonth(DataInputStream &in)
        :Vectorr(in)
    {
        int size = Vectorr::getRow() * Vectorr::getClm();
        int y, m, d;
        Rcpp::DateVector vec(size);
        origin_v.reserve(size);
        for (int i = 0; i < size; i++)
        {
            int temp;
            in.readInt(temp);
            origin_v.push_back(temp);
            Utill::ParseMonth(temp, y, m, d);
            vec[i] = Date(y, m, d);
            if (temp == DDB_NULL_INTEGER)
            {
                Vectorr::getNAIndex().push_back(i+1);
            }
        }
        _vec = vec;
    }
    ~VectorMonth() {}

    void* getVector() { return _vec; }
    
    bool isDate() { return true; }
    void* getStringVector() {
        int size = Vectorr::getRow() * Vectorr::getClm();
        str_vec.reserve(size);
        for (int i = 0; i < size; i++)
        {
            int temp = origin_v[i];
            string date_str = Utill::ParseMonth(temp);
            str_vec.push_back(date_str);
        }
        return (void*)&str_vec;
    }
};

class VectorDateTime : public Vectorr 
{
private: 
    Rcpp::NumericVector vec;
    vector<string> str_vec; 
    vector<int> origin_v;
public: 
    VectorDateTime(DataInputStream &in)
        :Vectorr(in)
    {
        int size = Vectorr::getRow() * Vectorr::getClm();
        vec = Rcpp::DatetimeVector(size);
        vec.attr("class") = Rcpp::CharacterVector::create("POSIXct", "POSIXt");
        vec.attr("tzone") = std::string("UTC");
        origin_v.reserve(size);
        for (int i = 0; i < size; i++)
        {
            int temp;
            in.readInt(temp);
            vec[i] = (double)temp;
            origin_v.push_back(temp);
            if (temp == DDB_NULL_INTEGER)
            {
                Vectorr::getNAIndex().push_back(i+1);
            }
        }
    }
    ~VectorDateTime() {}

    void* getVector() {return vec;}
    bool isDate() { return true; }
    void* getStringVector() {
        int size = Vectorr::getRow() * Vectorr::getClm();
        str_vec.reserve(size);
        for (int i = 0; i < size; i++)
        {
            int temp = origin_v[i];
            string date_str = Utill::ParseDateTime(temp);
            str_vec.push_back(date_str);
        }
        return (void*)&str_vec;
    }
};

class VectorTime : public Vectorr
{
private:
    Rcpp::NumericVector vec;
    vector<string> str_vec; 
    vector<int> origin_v;
public:
    VectorTime(DataInputStream &in)
        :Vectorr(in)
    {
        int size = Vectorr::getRow() * Vectorr::getClm();
        vec = Rcpp::NumericVector(size);
        vec.attr("class") = Rcpp::CharacterVector::create("POSIXct", "POSIXt");
        vec.attr("tzone") = std::string("UTC");
        origin_v.reserve(size);
        for (int i = 0; i < size; i++)
        {
            int temp;
            in.readInt(temp);
            origin_v.push_back(temp);
            vec[i] = (double)temp/1000;
            if (temp == DDB_NULL_INTEGER)
            {
                Vectorr::getNAIndex().push_back(i+1);
            }
        }
    }
    ~VectorTime() {}

    void* getVector() {return vec;}
    bool isDate() { return true; }
    void* getStringVector() {
        int size = Vectorr::getRow() * Vectorr::getClm();
        str_vec.reserve(size);
        for (int i = 0; i < size; i++)
        {
            int temp = origin_v[i];
            string date_str = Utill::ParseTime(temp);
            str_vec.push_back(date_str);
        }
        return (void*)&str_vec;
    }
};

class VectorMinute : public Vectorr
{
private:
    Rcpp::NumericVector vec;
    vector<string> str_vec; 
    vector<int> origin_v;
public:
    VectorMinute(DataInputStream &in)
        :Vectorr(in)
    {
        int size = Vectorr::getRow() * Vectorr::getClm();
        vec = Rcpp::NumericVector(size);
        vec.attr("class") = Rcpp::CharacterVector::create("POSIXct", "POSIXt");
        vec.attr("tzone") = std::string("UTC");
        origin_v.reserve(size);
        for (int i = 0; i < size; i++)
        {
            int temp;
            in.readInt(temp);
            origin_v.push_back(temp);
            vec[i] = (double)(temp*60);
            if (temp == DDB_NULL_INTEGER)
            {
                Vectorr::getNAIndex().push_back(i+1);
            }
        }
    }
    ~VectorMinute() {}

    void* getVector() {return vec;}
    bool isDate() { return true; }
    void* getStringVector() {
        int size = Vectorr::getRow() * Vectorr::getClm();
        str_vec.reserve(size);
        for (int i = 0; i < size; i++)
        {
            int temp = origin_v[i];
            string date_str = Utill::ParseMinute(temp);
            str_vec.push_back(date_str);
        }
        return (void*)&str_vec;
    }
};

class VectorSecond : public Vectorr 
{
private:
    Rcpp::NumericVector vec;
    vector<string> str_vec; 
    vector<int> origin_v;
public:
    VectorSecond(DataInputStream &in)
        :Vectorr(in)
    {
        int size = Vectorr::getRow() * Vectorr::getClm();
        vec = Rcpp::NumericVector(size);
        vec.attr("class") = Rcpp::CharacterVector::create("POSIXct", "POSIXt");
        vec.attr("tzone") = std::string("UTC");
        origin_v.reserve(size);
        for (int i = 0; i < size; i++)
        {
            int temp;
            in.readInt(temp);
            origin_v.push_back(temp);
            vec[i] = ((double)temp);
            if (temp == DDB_NULL_INTEGER)
            {
                Vectorr::getNAIndex().push_back(i+1);
            }
        }
    }
    ~VectorSecond() {}

    void* getVector() {return vec;}
    bool isDate() { return true; }
    void* getStringVector() {
        int size = Vectorr::getRow() * Vectorr::getClm();
        str_vec.reserve(size);
        for (int i = 0; i < size; i++)
        {
            int temp = origin_v[i];
            string date_str = Utill::ParseSecond(temp);
            str_vec.push_back(date_str);
        }
        return (void*)&str_vec;
    }
};

class VectorTimestamp : public Vectorr
{
private:
    Rcpp::NumericVector vec;
    vector<string> str_vec; 
    vector<long long> origin_v;
public:
    VectorTimestamp(DataInputStream &in)
        :Vectorr(in)
    {
        int size = Vectorr::getRow() * Vectorr::getClm();
        vec = Rcpp::NumericVector(size);
        vec.attr("class") = Rcpp::CharacterVector::create("POSIXct", "POSIXt");
        vec.attr("tzone") = std::string("UTC");
        origin_v.reserve(size);
        for (int i = 0; i < size; i++)
        {
            long long temp;
            in.readLong(temp);
            origin_v.push_back(temp);
            vec[i] = ((double)temp)/1000; // milliseconds
            if (temp < DDB_NULL_LONG)
            {
                Vectorr::getNAIndex().push_back(i+1);
            }
        }
    }
    ~VectorTimestamp() {}

    void* getVector() {return vec;}
    bool isDate() { return true; }
    void* getStringVector() {
        int size = Vectorr::getRow() * Vectorr::getClm();
        str_vec.reserve(size);
        for (int i = 0; i < size; i++)
        {
            long long temp = origin_v[i];
            string date_str = Utill::ParseTimestamp(temp);
            str_vec.push_back(date_str);
        }
        return (void*)&str_vec;
    }
};

// TODO: create a new class instead of POSIXct
class VectorNanotime : public Vectorr
{
private:
    Rcpp::NumericVector vec;
    vector<string> str_vec; 
    vector<long long> origin_v;
public:
    VectorNanotime(DataInputStream &in)
        :Vectorr(in)
    {
        int size = Vectorr::getRow() * Vectorr::getClm();
        vec = Rcpp::NumericVector(size);
        vec.attr("class") = Rcpp::CharacterVector::create("POSIXct", "POSIXt");
        vec.attr("tzone") = std::string("UTC");
        origin_v.reserve(size);
        for (int i = 0; i < size; i++)
        {
            long long temp;
            in.readLong(temp);
            origin_v.push_back(temp);
            vec[i] = ((double)temp)/1000000000L;
            if (temp < DDB_NULL_LONG)
            {
                Vectorr::getNAIndex().push_back(i+1);
            }
        }
    }
    ~VectorNanotime() {}

    void* getVector() {return vec;}
    bool isDate() { return true; }
    void* getStringVector() {
        int size = Vectorr::getRow() * Vectorr::getClm();
        str_vec.reserve(size);
        for (int i = 0; i < size; i++)
        {
            long long temp = origin_v[i];
            string date_str = Utill::ParseNanotime(temp);
            str_vec.push_back(date_str);
        }
        return (void*)&str_vec;
    }
};

// TODO: create a new class instead of POSIXct
class VectorNanotimestamp : public Vectorr
{
private:
    Rcpp::NumericVector vec;
    vector<string> str_vec; 
    vector<long long> origin_v;
public:
    VectorNanotimestamp(DataInputStream &in)
        :Vectorr(in)
    {
        int size = Vectorr::getRow() * Vectorr::getClm();
        vec = Rcpp::NumericVector(size);
        vec.attr("class") = Rcpp::CharacterVector::create("POSIXct", "POSIXt");
        vec.attr("tzone") = std::string("UTC");
        origin_v.reserve(size);
        for (int i = 0; i < size; i++)
        {
            long long temp;
            in.readLong(temp);
            origin_v.push_back(temp);
            vec[i] = ((double)temp)/1000000000L;
            if (temp < DDB_NULL_LONG)
            {
                Vectorr::getNAIndex().push_back(i+1);
            }
        }
    }
    ~VectorNanotimestamp() {}

    void* getVector() {return vec;}
    bool isDate() { return true; }
    void* getStringVector() {
        int size = Vectorr::getRow() * Vectorr::getClm();
        str_vec.reserve(size);
        for (int i = 0; i < size; i++)
        {
            long long temp = origin_v[i];
            string date_str = Utill::ParseNanotimestamp(temp);
            str_vec.push_back(date_str);
        }
        return (void*)&str_vec;
    }
};

int CreateVector(Vectorr*& vector_ptr, int data_type, DataInputStream& in)
{
    // cout << data_type << endl;
    switch(data_type)
    {
        case DATA_TYPE::DT_BOOL:
            vector_ptr = new VectorBool(in);
            return VECTOR_LOGICAL;

        case DATA_TYPE::DT_INT:
            vector_ptr = new VectorInt(in);
            return VECTOR_INTEGER;

        case DATA_TYPE::DT_SHORT: 
            vector_ptr = new VectorShort(in);
            return VECTOR_INTEGER;
            
        case DATA_TYPE::DT_DOUBLE:
            vector_ptr = new VectorDouble(in);
            return VECTOR_NUMERIC;

        case DATA_TYPE::DT_LONG: 
            vector_ptr = new VectorLong(in);
            return VECTOR_NUMERIC;

        case DATA_TYPE::DT_FLOAT: 
            vector_ptr = new VectorFloat(in);
            return VECTOR_NUMERIC;

        case DATA_TYPE::DT_CHAR:
            vector_ptr = new VectorChar(in);
            return VECTOR_INTEGER;

        case DATA_TYPE::DT_STRING:
            vector_ptr = new VectorString(in);
            return VECTOR_CHARACTER;

        case DATA_TYPE::DT_SYMBOL:
            vector_ptr = new VectorString(in);
            return VECTOR_CHARACTER;

        case DATA_TYPE::DT_DATE: 
            vector_ptr = new VectorDate(in);
            return VECTOR_DATE;

        case DATA_TYPE::DT_MONTH:
            vector_ptr = new VectorMonth(in);
            return VECTOR_DATE;

        case DATA_TYPE::DT_DATETIME: 
            vector_ptr = new VectorDateTime(in);
            return VECTOR_DATETIME;

        case DATA_TYPE::DT_TIME:
            vector_ptr = new VectorTime(in);
            return VECTOR_DATETIME;

        case DATA_TYPE::DT_MINUTE:
            vector_ptr = new VectorMinute(in);
            return VECTOR_DATETIME;

        case DATA_TYPE::DT_SECOND:
            vector_ptr = new VectorSecond(in);
            return VECTOR_DATETIME;

        case DATA_TYPE::DT_TIMESTAMP:
            vector_ptr = new VectorTimestamp(in);
            return VECTOR_DATETIME;

        case DATA_TYPE::DT_NANOTIME:
            vector_ptr = new VectorNanotime(in);
            return VECTOR_DATETIME;

        case DATA_TYPE::DT_NANOTIMESTAMP:
            vector_ptr = new VectorNanotimestamp(in);
            return VECTOR_DATETIME;
            
        default:
            // cout << "UNSURPORT VECTOR TYPE" << endl;
            break;
    }

    return VOIDD;
}

#endif