#ifndef _ENTITY_H_
#define _ENTITY_H_

/********************************************
 *
 * @Author -- Jingtang Zhang
 * @Date   -- 2018.7.16, Hangzhou
 * @Update -- 2018.8.17, Hangzhou
 * 
 ********************************************/

#include <iostream>

#include "Utill.h"
#include "Scalarr.h"
#include "Vectorr.h"
#include "Matrixx.h"
#include "Tablee.h"

/******************************************************************
 *
 * @Description
 * 
 *  A class which can store every form of data by pointer.
 *
 ******************************************************************/
class Entity 
{
private:
    int data_form;
    int data_type;

    Scalarr* scalar_ptr;
    Vectorr* vector_ptr;
    Matrixx* matrix_ptr;
    Tablee * table_ptr;


public:
    Entity(int df, int dt, DataInputStream& in);
    ~Entity();

    int getDataForm() {return data_form;}
    int getDataType() {return data_type;}

    Scalarr* getScalar() {return scalar_ptr;}
    Vectorr* getVector() {return vector_ptr;}
    Matrixx* getMatrix() {return matrix_ptr;}
    Tablee * getTable () {return table_ptr; }

private: 
    void CreateSet(DataInputStream &in);
};

Entity::~Entity()
{
    switch(data_form)
    {
        case DATA_FORM::DF_SCALAR:
            delete scalar_ptr;
            scalar_ptr = NULL;
            break;
        case DATA_FORM::DF_VECTOR:
            delete vector_ptr;
            vector_ptr = NULL;
            break;
        case DATA_FORM::DF_SET: 
            delete vector_ptr;
            vector_ptr = NULL;
            break;
        case DATA_FORM::DF_MATRIX:
            delete matrix_ptr;
            matrix_ptr = NULL;
            break;
        case DATA_FORM::DF_TABLE:
            delete table_ptr;
            table_ptr = NULL;
            break;
        default:
            // cout << "DATA FORM UNSURPORT" << endl;
            break;
    }
}

Entity::Entity(int df, int dt, DataInputStream& in)
    : data_form(df), data_type(dt),
      scalar_ptr(NULL), vector_ptr(NULL), matrix_ptr(NULL), table_ptr(NULL)
{
    switch(data_form)
    {
        case DATA_FORM::DF_SCALAR:
            CreateScalar(scalar_ptr, dt, in);
            break;
        case DATA_FORM::DF_VECTOR:
            CreateVector(vector_ptr, dt, in);
            break;
        case DATA_FORM::DF_PAIR:
            CreateVector(vector_ptr, dt, in);
            break;
        case DATA_FORM::DF_SET: 
            CreateSet(in);
            break;
        case DATA_FORM::DF_MATRIX:
            matrix_ptr = new Matrixx(in);
            break;
        case DATA_FORM::DF_TABLE:
            table_ptr = new Tablee(in);
            break;
        default:
            // cout << "DATA FORM UNSURPORT" << endl;
            break;
    }
}

void Entity::CreateSet(DataInputStream &in)
{
    short flag{};
    in.readShort(flag);
    int form = flag >> 8;
    int type = flag & 0xff;
    if (form != DATA_FORM::DF_VECTOR)
    {
        cout << "[Error] Content of a Set should be a Vector" << endl;
    }

    CreateVector(vector_ptr, type, in);
}

#endif