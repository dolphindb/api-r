#include <Rcpp.h>
#include <cmath>
using namespace Rcpp;

/*************************************************
 *
 * @Author -- Jingtang Zhang
 * @Date   -- 2018.7.15, Hangzhou
 * @Update -- 2018.8.16, Hangzhou
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
void UploadVectorDateTime(NumericVector R_vec, IntegerVector R_NAIndex)
{
    vector <double> vec = as <vector <double> > (R_vec);
    vector <int> NAIndex = as <vector <int> > (R_NAIndex);
    cnt.Rcpp_UploadDateTimeVector(vec, NAIndex);
}

//[[Rcpp::export]]
void UploadScalarDateTime(String date_time_str)
{
    cnt.Rcpp_UploadDateTimeScalar((date_time_str));
}

//[[Rcpp::export]]
void UploadVectorDate(DateVector R_vec, IntegerVector R_NAIndex)
{
    //vector <string> vec = as <vector <string> > (R_vec);
    vector <double> vec = as <vector <double> >(R_vec);
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
void UploadVectorSymbol(IntegerVector R_vec)
{
    std::vector<std::string> symbolBase;
    std::vector<int>         index;

    CharacterVector level = R_vec.attr("levels");
    LogicalVector isNaVec = is_na(level);
    int naIndex           = INT_MAX;

    //dolphindb中空值固定在首位，需要找到R中的空值位置并跳过
    symbolBase.push_back("");
    for(int i = 0; i < level.size(); ++i){
        if(isNaVec[i]){
            naIndex = i == INT_MAX ? i : i + 1;
        }
        else{
            symbolBase.push_back(std::string(level[i]));
        }
    }

    index.reserve(R_vec.size());
    for(int i = 0; i < R_vec.size(); ++i){
        if(R_vec[i] == naIndex){
            index.push_back(0);
        }
        else if(R_vec[i] > naIndex){
            index.push_back(R_vec[i] - 1);
        }
        else{
            index.push_back(R_vec[i]);
        }
    }

    cnt.Rcpp_UploadSymbolVector(symbolBase, index);
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
    if(std::isnan(val)){
        val = DDB_NULL_NUMERIC;
    }
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
IntegerVector ReturnAnyVectorTypelist()
{
    return wrap(cnt.Rcpp_GetAnyVector()->getRType());
}

//[[Rcpp::export]]
bool ReturnScalarNA(int index = -1)
{
    return cnt.Rcpp_GetEntity(index)->getScalar()->IsNull();
}

//[[Rcpp::export]]
bool ReturnScalarBool(int index = -1)
{
    return *(
        (bool *)
        (
            cnt.Rcpp_GetEntity(index)->
            getScalar()->
            getValue()
        )
    );
}

//[[Rcpp::export]]
int ReturnScalarInt(int index = -1)
{
    return *(
        (int *)
        (
            cnt.Rcpp_GetEntity(index)->
            getScalar()->
            getValue()
        )
    );
}

//[[Rcpp::export]]
double ReturnScalarDouble(int index = -1)
{
    return 
    *(
        (double *)
        (
            cnt.Rcpp_GetEntity(index)->
            getScalar()->
            getValue()
        )
    );
}

//[[Rcpp::export]]
String ReturnScalarString(int index = -1)
{
    return *(
        (string *)
        (
            cnt.Rcpp_GetEntity(index)->
            getScalar()->
            getValue()
        )
    );
}

//[[Rcpp::export]]
NumericVector ReturnScalarTime(int index = -1)
{
    void* tmp = cnt.Rcpp_GetEntity(index)->
            getScalar()->
            getValue();
    return *(NumericVector*)&tmp;
}


//[[Rcpp::export]]
NumericVector ReturnScalarDate(int index = -1)
{
    void* tmp = cnt.Rcpp_GetEntity(index)->
            getScalar()->
            getValue();
    return *(NumericVector*)&tmp;
}

//[[Rcpp::export]]
LogicalVector ReturnVectorBool(int index = -1)
{
    return wrap(
        *(
            (vector <bool> *)
            (
                cnt.Rcpp_GetEntity(index)->
                getVector()->
                getVector()
            )
        )
    );
}

//[[Rcpp::export]]
IntegerVector ReturnVectorFactor(int index = -1)
{
    void* tmp = cnt.Rcpp_GetEntity(index)->
                getVector()->
                getVector();
    return wrap(*((IntegerVector*)tmp));
}

//[[Rcpp::export]]
IntegerVector ReturnVectorInt(int index = -1)
{
    // No Need to convert -2147483648
    return wrap(
        *(
            (vector <int> *)
            (
                cnt.Rcpp_GetEntity(index)->
                getVector()->
                getVector()
            )
        )
    );
}

//[[Rcpp::export]]
NumericVector ReturnVectorDouble(int index = -1)
{
    return wrap(
        *(
            (vector <double> *)
            (
                cnt.Rcpp_GetEntity(index)->
                getVector()->
                getVector()
            )
        )
    );
}

//[[Rcpp::export]]
CharacterVector ReturnVectorString(int index = -1)
{
    return wrap(
        *(
            (vector <string> *)
            (
                cnt.Rcpp_GetEntity(index)->
                getVector()->
                getVector()
            )
        )
    );
}

//[[Rcpp::export]]
DateVector ReturnVectorDate(int index = -1)
{
    void* tmp = cnt.Rcpp_GetEntity(index)->
                getVector()->
                getVector();
    return wrap(*((DateVector*)&tmp));
}

//[[Rcpp::export]]
NumericVector ReturnVectorTime(int index = -1)
{
    void* tmp = cnt.Rcpp_GetEntity(index)->
                getVector()->
                getVector();
    return wrap(*((NumericVector*)&tmp));
}

//[[Rcpp::export]]
IntegerVector ReturnVectorNAIndex(int index = -1)
{
    return wrap(
        cnt.Rcpp_GetEntity(index)->
        getVector()->
        getNAIndex()
    );
}

//[[Rcpp::export]]
bool ReturnMatrixHasLable(bool row, int index = -1)
{
    if (row)
    {
        return cnt.Rcpp_GetEntity(index)->getMatrix()->hasRowLable();
    }
    else 
    {
        return cnt.Rcpp_GetEntity(index)->getMatrix()->hasClmLable();
    }
}

//[[Rcpp::export]]
int ReturnMatrixLableType(bool row, int index = -1)
{
    if (row)
    {
        return cnt.Rcpp_ReturnRType(
            DATA_FORM::DF_VECTOR,
            cnt.Rcpp_GetEntity(index)->getMatrix()->getRowLableType()
        );
    }
    else 
    {
        return cnt.Rcpp_ReturnRType(
            DATA_FORM::DF_VECTOR,
            cnt.Rcpp_GetEntity(index)->getMatrix()->getClmLableType()
        );
    }
}

//[[Rcpp::export]]
IntegerVector ReturnMatrixLableNAIndex(bool row, int index = -1)
{
    if (row)
    {
        return wrap(
            cnt.Rcpp_GetEntity(index)->getMatrix()->getRowLableNAIndex()
        );
    }
    else 
    {
        return wrap(
            cnt.Rcpp_GetEntity(index)->getMatrix()->getClmLableNAIndex()
        );
    }
}

//[[Rcpp::export]]
LogicalVector ReturnMatrixVectorBoolLable(bool row, int index = -1)
{
    if (row)
    {
        return wrap(
            *(
                (vector <bool>*)
                (
                    cnt.Rcpp_GetEntity(index)-> 
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
                    cnt.Rcpp_GetEntity(index)-> 
                    getMatrix()-> 
                    getClmLable()
                )
            )
        );
    }
}

//[[Rcpp::export]]
IntegerVector ReturnMatrixVectorIntLable(bool row, int index = -1)
{
    if (row)
    {
        return wrap(
            *(
                (vector <int>*)
                (
                    cnt.Rcpp_GetEntity(index)-> 
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
                    cnt.Rcpp_GetEntity(index)-> 
                    getMatrix()-> 
                    getClmLable()
                )
            )
        );
    }
}

//[[Rcpp::export]]
NumericVector ReturnMatrixVectorDoubleLable(bool row, int index = -1)
{
    if (row)
    {
        return wrap(
            *(
                (vector <double>*)
                (
                    cnt.Rcpp_GetEntity(index)-> 
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
                    cnt.Rcpp_GetEntity(index)-> 
                    getMatrix()-> 
                    getClmLable()
                )
            )
        );
    }
}

//[[Rcpp::export]]
CharacterVector ReturnMatrixVectorStringLable(bool row, int index = -1)
{
    if (row)
    {
        return wrap(
            *(
                (vector <string>*)
                (
                    cnt.Rcpp_GetEntity(index)-> 
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
                    cnt.Rcpp_GetEntity(index)-> 
                    getMatrix()-> 
                    getClmLable()
                )
            )
        );
    }
}

//[[Rcpp::export]]
LogicalMatrix ReturnMatrixBool(int index = -1)
{
    vector <bool>& mtx = *(
        (vector <bool>*)
        (
            cnt.Rcpp_GetEntity(index)->
            getMatrix()->
            getMatrix()
        )
    );
    return LogicalMatrix(
        cnt.Rcpp_GetEntity(index)->getMatrix()->getRow(),
        cnt.Rcpp_GetEntity(index)->getMatrix()->getClm(),
        mtx.begin()
    );
}

//[[Rcpp::export]]
IntegerMatrix ReturnMatrixInt(int index = -1)
{
    vector <int>& mtx = *(
        (vector <int>*)
        (
            cnt.Rcpp_GetEntity(index)->
            getMatrix()->
            getMatrix()
        )
    );
    return IntegerMatrix(
        cnt.Rcpp_GetEntity(index)->getMatrix()->getRow(),
        cnt.Rcpp_GetEntity(index)->getMatrix()->getClm(),
        mtx.begin()
    );
}

//[[Rcpp::export]]
NumericMatrix ReturnMatrixDouble(int index = -1)
{
    vector <double>& mtx = *(
        (vector <double>*)
        (
            cnt.Rcpp_GetEntity(index)->
            getMatrix()->
            getMatrix()
        )
    );
    return NumericMatrix(
        cnt.Rcpp_GetEntity(index)->getMatrix()->getRow(),
        cnt.Rcpp_GetEntity(index)->getMatrix()->getClm(),
        mtx.begin()
    );
}

//[[Rcpp::export]]
CharacterMatrix ReturnMatrixString(int index = -1)
{
    vector <string>&mtx = *(
        (vector <string>*)
        (
            cnt.Rcpp_GetEntity(index)-> 
            getMatrix()-> 
            getMatrix()
        )
    );
    return CharacterMatrix(
        cnt.Rcpp_GetEntity(index)->getMatrix()->getRow(),
        cnt.Rcpp_GetEntity(index)->getMatrix()->getClm(),
        mtx.begin()
    );
}

//[[Rcpp::export]]
IntegerVector ReturnMatrixNAIndex(int index = -1)
{
    return wrap(
        cnt.Rcpp_GetEntity(index)->
        getMatrix()->
        getMatrixNAIndex()
    );
}

//[[Rcpp::export]]
IntegerVector ReturnTableColumnType(int index = -1)
{
    return wrap(
        cnt.Rcpp_GetEntity(index)->
        getTable()->
        getTableClmType()
    );
}

//[[Rcpp::export]]
CharacterVector ReturnTableColumeName(int index = -1)
{
    return wrap(
        cnt.Rcpp_GetEntity(index)->
        getTable()->
        getTableClmName()
    );
}

//[[Rcpp::export]]
DataFrame ReturnEmptyDataFrame(int index = -1)
{
    vector <int> temp(
        cnt.Rcpp_GetEntity(index)->
        getTable()->
        getTableRow()
    );
    return DataFrame::create(Named("temp") = temp);
}

//[[Rcpp::export]]
LogicalVector ReturnTableColumnLogical(int index, int entity_index = -1)
{
    return wrap(
        *(vector <bool>*)
        (
            cnt.Rcpp_GetEntity(entity_index)->
            getTable()->
            getTableClm(index-1)->
            getVector()
        )
    );
}

//[[Rcpp::export]]
IntegerVector ReturnTableColumnFactor(int index, int entity_index = -1)
{
    void* tmp = cnt.Rcpp_GetEntity(entity_index)->
                getTable()->
                getTableClm(index-1)->
                getVector();
    return wrap(*((IntegerVector*)tmp));
}

//[[Rcpp::export]]
IntegerVector ReturnTableColumnInteger(int index, int entity_index = -1)
{
    return wrap(
        *(vector <int>*)
        (
            cnt.Rcpp_GetEntity(entity_index)->
            getTable()->
            getTableClm(index-1)->
            getVector()
        )
    );
}

//[[Rcpp::export]]
NumericVector ReturnTableColumnDouble(int index, int entity_index = -1)
{
    return wrap(
        *(vector <double>*)
        (
            cnt.Rcpp_GetEntity(entity_index)->
            getTable()->
            getTableClm(index-1)->
            getVector()
        )
    );
}

//[[Rcpp::export]]
NumericVector ReturnTableColumnTime(int index, int entity_index = -1)
{
    void* tmp = cnt.Rcpp_GetEntity(entity_index)->
            getTable()->
            getTableClm(index-1)->
            getVector();
    return *(NumericVector*)&tmp;
}

//[[Rcpp::export]]
DateVector ReturnTableColumnDate(int index, int entity_index = -1)
{
    void* tmp = cnt.Rcpp_GetEntity(entity_index)->
            getTable()->
            getTableClm(index-1)->
            getVector();
    return *(DateVector*)&tmp;
}

//[[Rcpp::export]]
CharacterVector ReturnTableColumnString(int index, int entity_index = -1)
{
    return wrap(
        *(vector <string>*)
        (
            cnt.Rcpp_GetEntity(entity_index)->
            getTable()->
            getTableClm(index-1)->
            getVector()
        )
    );
}

//[[Rcpp::export]]
IntegerVector ReturnTableColumnNAIndex(int index, int entity_index = -1)
{
    return wrap(
        (
            cnt.Rcpp_GetEntity(entity_index)->
            getTable()->
            getTableClm(index-1)->
            getNAIndex()
        )
    );
}
