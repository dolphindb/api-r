#ifndef _MATRIXX_H_
#define _MATRIXX_H_

/***********************************************
 *
 * @Author -- Jingtang Zhang
 * @Date   -- 2018.7.16, Hangzhou
 * @Update -- 2018.8.1 , Hangzhou
 * 
 ***********************************************/

#include <iostream>
#include <vector>
using namespace std;

#include "Vectorr.h"
#include "Socket/SysIO.h"

/******************************************************************
 *
 * @Description
 * 
 *  Class of MATRIX
 *  
 *  Store basic information of a matrix
 *  Store the matrix and lables in the form of Vector
 *
 ******************************************************************/
class Matrixx
{
private:
    char has_lable;
    bool has_row_lable;
    bool has_clm_lable;
    int lable_row_dt;
    int lable_clm_dt;
    Vectorr* lable_row;
    Vectorr* lable_clm;

    int matrix_type;
    Vectorr* mtx;

public:
    Matrixx(DataInputStream &in);
    ~Matrixx();

    int getRow() {return mtx->getRow();}
    int getClm() {return mtx->getClm();}
    bool hasRowLable() {return has_row_lable;}
    bool hasClmLable() {return has_clm_lable;}
    int getRowLableType() {return lable_row_dt;}
    int getClmLableType() {return lable_clm_dt;}
    int getMatrixType() {return matrix_type;}
    vector <int>& getRowLableNAIndex() {return lable_row->getNAIndex();}
    vector <int>& getClmLableNAIndex() {return lable_clm->getNAIndex();}
    vector <int>& getMatrixNAIndex() {return mtx->getNAIndex();}

    void* getRowLable() {return lable_row->getVector();}
    void* getClmLable() {return lable_clm->getVector();}
    void* getMatrix() {
        if(mtx->isDate() || mtx->isString()) {
            return mtx->getStringVector();
        }
        return mtx->getVector();
    }
};

Matrixx::Matrixx(DataInputStream &in)
    :has_row_lable(false), has_clm_lable(false),
     lable_row_dt(-1), lable_clm_dt(-1),
     lable_row(NULL), lable_clm(NULL)
{
    in.readChar(has_lable);

    if ((has_lable & 1) == 1)
    {
        has_row_lable = true;
        short flag;
        in.readShort(flag);
        lable_row_dt = flag & 0xff;
        if (flag >> 8 != DATA_FORM::DF_VECTOR)
        {
            cout << "[ERROR] The form of matrix row lables must bu a VECTOR" << endl;
        }

        CreateVector(lable_row, lable_row_dt, in);
    }

    if ((has_lable & 2) == 2)
    {
        has_clm_lable = true;
        short flag;
        in.readShort(flag);
        lable_clm_dt = flag & 0xff;
        if (flag >> 8 != DATA_FORM::DF_VECTOR)
        {
            cout << "[ERROR] The form of matrix row lables must bu a VECTOR" << endl;
        }

        CreateVector(lable_clm, lable_clm_dt, in);
    }

    short flag;
    in.readShort(flag);
    matrix_type = flag & 0xff;

    CreateVector(mtx, matrix_type, in);
}

Matrixx::~Matrixx()
{
    if (lable_row != NULL)
    {
        delete lable_row;
        lable_row = NULL;
    }
    if (lable_clm != NULL)
    {
        delete lable_clm;
        lable_clm = NULL;
    }
    if (mtx != NULL)
    {
        delete mtx;
        mtx = NULL;
    }
}

#endif