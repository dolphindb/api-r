#ifndef _R_TYPE_H_
#define _R_TYPE_H_

/***************************************************
 *
 * @Author -- Jingtang Zhang
 * @Date   -- 2018.7.18, Hangzhou
 * @Update -- 2018.8.17, Hangzhou
 * 
 **************************************************/

/***************************************************
 *
 * @Description
 * 
 *  Define the return value of FORM and TYPE in R
 * 
 **************************************************/

#include <float.h>
#include <limits.h>

#define ERRORR -1

enum R_TYPE {
    VOIDD = 0,
    SCALAR_LOGICAL, SCALAR_INTEGER, SCALAR_NUMERIC, SCALAR_CHARACTER,
    VECTOR_LOGICAL, VECTOR_INTEGER, VECTOR_NUMERIC, VECTOR_CHARACTER,
    MATRIX_LOGICAL, MATRIX_INTEGER, MATRIX_NUMERIC, MATRIX_CHARACTER,
    TABLEE,
    SCALAR_DATE, SCALAR_DATETIME,
    VECTOR_DATE, VECTOR_DATETIME,
    MATRIX_DATE, MATRIX_DATETIME,
    VECTOR_ANY
};

#define DDB_NULL_INTEGER -2147483648
#define DDB_NULL_SHORT -32768
#define DDB_NULL_BYTE 0x80
#define DDB_NULL_NUMERIC -DBL_MAX
#define DDB_NULL_FLOAT -FLT_MAX
#ifdef __APPLE__
    #define DDB_NULL_LONG -LLONG_MAXS
#else
    #define DDB_NULL_LONG -LONG_LONG_MAX
#endif

const int cumMonthDays[] = {0,31,59,90,120,151,181,212,243,273,304,334,365};
const int cumLeapMonthDays[] = {0,31,60,91,121,152,182,213,244,274,305,335,366};
const int monthDays[] = {31,28,31,30,31,30,31,31,30,31,30,31};
const int leapMonthDays[] = {31,29,31,30,31,30,31,31,30,31,30,31};

#endif