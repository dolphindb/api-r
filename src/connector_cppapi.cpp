#include <Rcpp.h>
using namespace Rcpp;

/*************************************************
 *
 * @Author -- Jingtang Zhang
 * @Date   -- 2018.7.15, Hangzhou
 * @Update -- 2018.8.1, Hangzhou
 * 
 *************************************************/

/* ***********************************************
 *
 * @Description
 * 
 *  The functions below willed be converted
 *  to R functions with the same names.
 *  
 *  Different return type and arguments
 *  in C++ should be provided.
 * 
 *  A global instance of class [Rcpp_Connector]
 *  is maintained as a handler to call
 *  functions of [Rcpp_Connector]
 * 
 * ***********************************************/

#include <iostream>
#include <vector>
#include <string>

using std::cout;
using std::endl;
using std::vector;
using std::string;

#include "include/R_CPP_Connector.h"
#include "include/R_Type.h"

Rcpp_Connector cnt;

//[[Rcpp::export]]
bool Connect(String host, int port)
{
    return cnt.Rcpp_Connect(
        (host),
        port
    );
}

//[[Rcpp::export]]
int RunScript(String script)
{
    if (cnt.Rcpp_RunScriptInit((script)) == true)
    {
        return cnt.Rcpp_ReceiveEntity();
    }
    else 
    {
        return ERRORR;
    }
}

//[[Rcpp::export]]
bool RunFunctionInit(String func, int arg_size)
{
    return cnt.Rcpp_RunFunctionInit((func), arg_size);
}

//[[Rcpp::export]]
bool RunUploadInit(CharacterVector R_keys)
{
    vector <string> keys = as <vector <string> > (R_keys);
    return cnt.Rcpp_RunUploadInit(keys);
}

//[[Rcpp::export]]
bool ReceiveHeader()
{
    return cnt.Rcpp_ReceiveHeader();
}

//[[Rcpp::export]]
int ReceiveEntity()
{
    return cnt.Rcpp_ReceiveEntity();
}

//[[Rcpp::export]]
void UploadVectorDateTime(CharacterVector R_vec, IntegerVector R_NAIndex)
{
    vector <string> vec = as <vector <string> > (R_vec);
    vector <int> NAIndex = as <vector <int> > (R_NAIndex);
    cnt.Rcpp_UploadDateTimeVector(vec, NAIndex);
}

//[[Rcpp::export]]
void UploadScalarDateTime(String date_time_str)
{
    cnt.Rcpp_UploadDateTimeScalar((date_time_str));
}

//[[Rcpp::export]]
void UploadVectorDate(CharacterVector R_vec, IntegerVector R_NAIndex)
{
    vector <string> vec = as <vector <string> > (R_vec);
    vector <int> NAIndex = as <vector <int> > (R_NAIndex);
    cnt.Rcpp_UploadDateVector(vec, NAIndex);
}

//[[Rcpp::export]]
void UploadScalarDate(String date_str)
{
    cnt.Rcpp_UploadDateScalar((date_str));
}

//[[Rcpp::export]]
void UploadTableBasic(int row, int clm, CharacterVector Colnames)
{
    vector <string> colnames = as <vector <string> > (Colnames);
    cnt.Rcpp_UploadTableBasic(row, clm, colnames);
}

//[[Rcpp::export]]
void UploadMatrixNULL(int row, int clm)
{
    cnt.Rcpp_UploadEmptyMatrix(row, clm);
}

//[[Rcpp::export]]
void UploadMatrixLableFlag(int flag)
{
    cnt.Rcpp_UploadMatrixLableFlag(flag);
}

//[[Rcpp::export]]
void UploadMatrixFlag(int flag)
{
    cnt.Rcpp_UploadMatrixBasic(flag);
}

//[[Rcpp::export]]
void UploadMatrixBool(LogicalMatrix R_mtx, IntegerVector R_NAIndex)
{
    vector <bool> mtx = as <vector <bool> > (R_mtx);
    vector <int> NAIndex = as <vector <int> > (R_NAIndex);
    cnt.Rcpp_UploadEntity(mtx, NAIndex, R_mtx.nrow(), R_mtx.ncol());
}

//[[Rcpp::export]]
void UploadMatrixInt(IntegerMatrix R_mtx, IntegerVector R_NAIndex)
{
    vector <int> mtx = as <vector <int> > (R_mtx);
    vector <int> NAIndex = as <vector <int> > (R_NAIndex);
    cnt.Rcpp_UploadEntity(mtx, NAIndex, R_mtx.nrow(), R_mtx.ncol());
}

//[[Rcpp::export]]
void UploadMatrixDouble(NumericMatrix R_mtx, IntegerVector R_NAIndex)
{
    vector <double> mtx = as <vector <double> > (R_mtx);
    vector <int> NAIndex = as <vector <int> > (R_NAIndex);
    cnt.Rcpp_UploadEntity(mtx, NAIndex, R_mtx.nrow(), R_mtx.ncol());
}

//[[Rcpp::export]]
void UploadVectorString(CharacterVector R_vec, IntegerVector R_NAIndex)
{
    vector <string> vec = as <vector <string> > (R_vec);
    vector <int> NAIndex = as <vector <int> > (R_NAIndex);
    cnt.Rcpp_UploadEntity(vec, NAIndex);
}

//[[Rcpp::export]]
void UploadVectorDouble(NumericVector R_vec, IntegerVector R_NAIndex)
{
    vector <double> vec = as <vector <double> > (R_vec);
    vector <int> NAIndex = as <vector <int> > (R_NAIndex);
    cnt.Rcpp_UploadEntity(vec, NAIndex);
}

//[[Rcpp::export]]
void UploadVectorBool(LogicalVector R_vec, IntegerVector R_NAIndex)
{
    vector <bool> vec = as <vector <bool> > (R_vec);
    vector <int> NAIndex = as <vector <int> > (R_NAIndex);
    cnt.Rcpp_UploadEntity(vec, NAIndex);
}

//[[Rcpp::export]]
void UploadVectorInt(IntegerVector R_vec, IntegerVector R_NAIndex)
{
    vector <int> vec = as <vector <int> > (R_vec);
    vector <int> NAIndex = as <vector <int> > (R_NAIndex);
    cnt.Rcpp_UploadEntity(vec, NAIndex);
}

//[[Rcpp::export]]
void UploadVectorNULL(int row, int clm)
{
    cnt.Rcpp_UploadEmptyVector(row, clm);
}

//[[Rcpp::export]]
void UploadScalarInt(int val)
{
    cnt.Rcpp_UploadEntity(val);
}

//[[Rcpp::export]]
void UploadScalarBool(bool val)
{
    cnt.Rcpp_UploadEntity((char) val);
}

//[[Rcpp::export]]
void UploadScalarNULL()
{
    cnt.Rcpp_UploadEmptyScalar();
}

//[[Rcpp::export]]
void UploadScalarDouble(double val)
{
    cnt.Rcpp_UploadEntity(val);
}

//[[Rcpp::export]]
void UploadScalarString(String val)
{
    cnt.Rcpp_UploadEntity((val));
}

//[[Rcpp::export]]
void Clear()
{
    cnt.Rcpp_ClearEntity();
}

//[[Rcpp::export]]
void DisConnect()
{
    cnt.Rcpp_DisConnect();
}

//[[Rcpp::export]]
bool ReturnScalarNA()
{
    return cnt.Rcpp_GetEntity()->getScalar()->IsNull();
}

//[[Rcpp::export]]
bool ReturnScalarBool()
{
    return *(
        (bool *)
        (
            cnt.Rcpp_GetEntity()->
            getScalar()->
            getValue()
        )
    );
}

//[[Rcpp::export]]
int ReturnScalarInt()
{
    return *(
        (int *)
        (
            cnt.Rcpp_GetEntity()->
            getScalar()->
            getValue()
        )
    );
}

//[[Rcpp::export]]
double ReturnScalarDouble()
{
    return 
    *(
        (double *)
        (
            cnt.Rcpp_GetEntity()->
            getScalar()->
            getValue()
        )
    );
}

//[[Rcpp::export]]
String ReturnScalarString()
{
    return *(
        (string *)
        (
            cnt.Rcpp_GetEntity()->
            getScalar()->
            getValue()
        )
    );
}

//[[Rcpp::export]]
LogicalVector ReturnVectorBool()
{
    return wrap(
        *(
            (vector <bool> *)
            (
                cnt.Rcpp_GetEntity()->
                getVector()->
                getVector()
            )
        )
    );
}

//[[Rcpp::export]]
IntegerVector ReturnVectorInt()
{
    // No Need to convert -2147483648
    return wrap(
        *(
            (vector <int> *)
            (
                cnt.Rcpp_GetEntity()->
                getVector()->
                getVector()
            )
        )
    );
}

//[[Rcpp::export]]
NumericVector ReturnVectorDouble()
{
    return wrap(
        *(
            (vector <double> *)
            (
                cnt.Rcpp_GetEntity()->
                getVector()->
                getVector()
            )
        )
    );
}

//[[Rcpp::export]]
CharacterVector ReturnVectorString()
{
    return wrap(
        *(
            (vector <string> *)
            (
                cnt.Rcpp_GetEntity()->
                getVector()->
                getVector()
            )
        )
    );
}

//[[Rcpp::export]]
IntegerVector ReturnVectorNAIndex()
{
    return wrap(
        cnt.Rcpp_GetEntity()->
        getVector()->
        getNAIndex()
    );
}

//[[Rcpp::export]]
bool ReturnMatrixHasLable(bool row)
{
    if (row)
    {
        return cnt.Rcpp_GetEntity()->getMatrix()->hasRowLable();
    }
    else 
    {
        return cnt.Rcpp_GetEntity()->getMatrix()->hasClmLable();
    }
}

//[[Rcpp::export]]
int ReturnMatrixLableType(bool row)
{
    if (row)
    {
        return cnt.Rcpp_ReturnRType(
            DATA_FORM::DF_VECTOR,
            cnt.Rcpp_GetEntity()->getMatrix()->getRowLableType()
        );
    }
    else 
    {
        return cnt.Rcpp_ReturnRType(
            DATA_FORM::DF_VECTOR,
            cnt.Rcpp_GetEntity()->getMatrix()->getClmLableType()
        );
    }
}

//[[Rcpp::export]]
IntegerVector ReturnMatrixLableNAIndex(bool row)
{
    if (row)
    {
        return wrap(
            cnt.Rcpp_GetEntity()->getMatrix()->getRowLableNAIndex()
        );
    }
    else 
    {
        return wrap(
            cnt.Rcpp_GetEntity()->getMatrix()->getClmLableNAIndex()
        );
    }
}

//[[Rcpp::export]]
LogicalVector ReturnMatrixVectorBoolLable(bool row)
{
    if (row)
    {
        return wrap(
            *(
                (vector <bool>*)
                (
                    cnt.Rcpp_GetEntity()-> 
                    getMatrix()-> 
                    getRowLable()
                )
            )
        );
    }
    else
    {
        return wrap(
            *(
                (vector <bool>*)
                (
                    cnt.Rcpp_GetEntity()-> 
                    getMatrix()-> 
                    getClmLable()
                )
            )
        );
    }
}

//[[Rcpp::export]]
IntegerVector ReturnMatrixVectorIntLable(bool row)
{
    if (row)
    {
        return wrap(
            *(
                (vector <int>*)
                (
                    cnt.Rcpp_GetEntity()-> 
                    getMatrix()-> 
                    getRowLable()
                )
            )
        );
    }
    else
    {
        return wrap(
            *(
                (vector <int>*)
                (
                    cnt.Rcpp_GetEntity()-> 
                    getMatrix()-> 
                    getClmLable()
                )
            )
        );
    }
}

//[[Rcpp::export]]
NumericVector ReturnMatrixVectorDoubleLable(bool row)
{
    if (row)
    {
        return wrap(
            *(
                (vector <double>*)
                (
                    cnt.Rcpp_GetEntity()-> 
                    getMatrix()-> 
                    getRowLable()
                )
            )
        );
    }
    else
    {
        return wrap(
            *(
                (vector <double>*)
                (
                    cnt.Rcpp_GetEntity()-> 
                    getMatrix()-> 
                    getClmLable()
                )
            )
        );
    }
}

//[[Rcpp::export]]
CharacterVector ReturnMatrixVectorStringLable(bool row)
{
    if (row)
    {
        return wrap(
            *(
                (vector <string>*)
                (
                    cnt.Rcpp_GetEntity()-> 
                    getMatrix()-> 
                    getRowLable()
                )
            )
        );
    }
    else
    {
        return wrap(
            *(
                (vector <string>*)
                (
                    cnt.Rcpp_GetEntity()-> 
                    getMatrix()-> 
                    getClmLable()
                )
            )
        );
    }
}

//[[Rcpp::export]]
LogicalMatrix ReturnMatrixBool()
{
    vector <bool>& mtx = *(
        (vector <bool>*)
        (
            cnt.Rcpp_GetEntity()->
            getMatrix()->
            getMatrix()
        )
    );
    return LogicalMatrix(
        cnt.Rcpp_GetEntity()->getMatrix()->getRow(),
        cnt.Rcpp_GetEntity()->getMatrix()->getClm(),
        mtx.begin()
    );
}

//[[Rcpp::export]]
IntegerMatrix ReturnMatrixInt()
{
    vector <int>& mtx = *(
        (vector <int>*)
        (
            cnt.Rcpp_GetEntity()->
            getMatrix()->
            getMatrix()
        )
    );
    return IntegerMatrix(
        cnt.Rcpp_GetEntity()->getMatrix()->getRow(),
        cnt.Rcpp_GetEntity()->getMatrix()->getClm(),
        mtx.begin()
    );
}

//[[Rcpp::export]]
NumericMatrix ReturnMatrixDouble()
{
    vector <double>& mtx = *(
        (vector <double>*)
        (
            cnt.Rcpp_GetEntity()->
            getMatrix()->
            getMatrix()
        )
    );
    return NumericMatrix(
        cnt.Rcpp_GetEntity()->getMatrix()->getRow(),
        cnt.Rcpp_GetEntity()->getMatrix()->getClm(),
        mtx.begin()
    );
}

//[[Rcpp::export]]
CharacterMatrix ReturnMatrixString()
{
    vector <string>&mtx = *(
        (vector <string>*)
        (
            cnt.Rcpp_GetEntity()-> 
            getMatrix()-> 
            getMatrix()
        )
    );
    return CharacterMatrix(
        cnt.Rcpp_GetEntity()->getMatrix()->getRow(),
        cnt.Rcpp_GetEntity()->getMatrix()->getClm(),
        mtx.begin()
    );
}

//[[Rcpp::export]]
IntegerVector ReturnMatrixNAIndex()
{
    return wrap(
        cnt.Rcpp_GetEntity()->
        getMatrix()->
        getMatrixNAIndex()
    );
}

//[[Rcpp::export]]
IntegerVector ReturnTableColumnType()
{
    return wrap(
        cnt.Rcpp_GetEntity()->
        getTable()->
        getTableClmType()
    );
}

//[[Rcpp::export]]
CharacterVector ReturnTableColumeName()
{
    return wrap(
        cnt.Rcpp_GetEntity()->
        getTable()->
        getTableClmName()
    );
}

//[[Rcpp::export]]
DataFrame ReturnEmptyDataFrame()
{
    vector <int> temp(
        cnt.Rcpp_GetEntity()->
        getTable()->
        getTableRow()
    );
    return DataFrame::create(Named("temp") = temp);
}

//[[Rcpp::export]]
LogicalVector ReturnTableColumnLogical(int index)
{
    return wrap(
        *(vector <bool>*)
        (
            cnt.Rcpp_GetEntity()->
            getTable()->
            getTableClm(index-1)->
            getVector()
        )
    );
}

//[[Rcpp::export]]
IntegerVector ReturnTableColumnInteger(int index)
{
    return wrap(
        *(vector <int>*)
        (
            cnt.Rcpp_GetEntity()->
            getTable()->
            getTableClm(index-1)->
            getVector()
        )
    );
}

//[[Rcpp::export]]
NumericVector ReturnTableColumnDouble(int index)
{
    return wrap(
        *(vector <double>*)
        (
            cnt.Rcpp_GetEntity()->
            getTable()->
            getTableClm(index-1)->
            getVector()
        )
    );
}

//[[Rcpp::export]]
CharacterVector ReturnTableColumnString(int index)
{
    return wrap(
        *(vector <string>*)
        (
            cnt.Rcpp_GetEntity()->
            getTable()->
            getTableClm(index-1)->
            getVector()
        )
    );
}

//[[Rcpp::export]]
IntegerVector ReturnTableColumnNAIndex(int index)
{
    return wrap(
        (
            cnt.Rcpp_GetEntity()->
            getTable()->
            getTableClm(index-1)->
            getNAIndex()
        )
    );
}
