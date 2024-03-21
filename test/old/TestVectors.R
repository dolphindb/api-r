# 
#
# @Author -- Jingtang Zhang
# @Date   -- 2018.7.31, Hangzhou
# @Update -- 2018.8.19, Ningbo
#
#

source("Assert.R") 

library("RDolphinDB")
conn <- dbConnect(DolphinDB(), ip_addr, port)
if (conn@connected == TRUE) {

    record <- c(0L, 0L)

    result <- dbRun(conn, "a = `EXE`ELF;symbol(a)")
    vec <- c("EXE", "ELF")
    record <- assert(record, "test symbol", result, vec)

    testList <- list(c("hello", "my", "world"))
    result <- dbRpc(conn, "concat", testList)
    scalar <- "hellomyworld"
    record <- assert(record, "test character vector rpc", result, scalar)

    # testList <- list(c("hello", NA, "world"))
    # result <- dbRpc(conn, "concat", testList)
    # scalar <- "helloworld"
    # record <- assert(record, "test character vector with NULL rpc", result, scalar)

    testList <- list(c(2.5, 3.5, 6.55))
    result <- dbRpc(conn, "sum", testList)
    scalar <- 12.55
    record <- assert(record, "test numeric vector rpc", result, scalar)

    testList <- list(c(2.5, NA, 6.55))
    result <- dbRpc(conn, "sum", testList)
    scalar <- 9.05
    record <- assert(record, "test numeric vector with NULL rpc", result, scalar)

    testList <- list(c(TRUE, TRUE, FALSE))
    result <- dbRpc(conn, "sum", testList)
    scalar <- 2
    record <- assert(record, "test logical vector rpc", result, scalar)

    testList <- list(c(TRUE, NA, FALSE))
    result <- dbRpc(conn, "sum", testList)
    scalar <- 1
    record <- assert(record, "test logical vector with NULL rpc", result, scalar)

    testList <- list(c(1L, 2L, 3L))
    result <- dbRpc(conn, "sum", testList)
    scalar <- 6L
    record <- assert(record, "test integer vector rpc", result, scalar)

    testList <- list(c(1L, NA, 3L))
    result <- dbRpc(conn, "sum", testList)
    scalar <- 4L
    record <- assert(record, "test integer vector with NULL rpc", result, scalar)

    testList <- list(c(NA, NA, NA))
    result <- dbRpc(conn, "sum", testList)
    scalar <- NA
    record <- assert(record, "test NULL vector rpc", result, scalar)

    result <- dbRun(conn, "00f NULL NULL")
    vec <- as.numeric(c(NA, NA, NA))
    record <- assert(record, "test NULL vector", result, vec)

    result <- dbRun(conn, "true false true")
    vec <- c(TRUE, FALSE, TRUE)
    record <- assert(record, "test bool vector", result, vec)

    result <- dbRun(conn, "sort(false true NULL)")
    vec <- c(NA, FALSE, TRUE)
    record <- assert(record, "test bool vector with NULL", result, vec)
    
    result <- dbRun(conn, "'a' 'b' 'c'")
    vec <- c(0x61, 0x62, 0x63)
    record <- assert(record, "test character vector", result, vec)

    result <- dbRun(conn, "5 6 7")
    vec <- c(5L, 6L, 7L)
    record <- assert(record, "test integer vector", result, vec)

    result <- dbRun(conn, "sort(5 NULL 7)")
    vec <- c(NA, 5L, 7L)
    record <- assert(record, "test integer vector with NULL", result, vec)

    result <- dbRun(conn, "3.5 9 6")
    vec <- c(3.5, 9, 6)
    record <- assert(record, "test double vector", result, vec)

    result <- dbRun(conn, "3.5 9 NULL")
    vec <- c(3.5, 9, NA)
    record <- assert(record, "test double vector with NULL", result, vec)

    result <- dbRun(conn, "`emm`666`ddd")
    vec <- c("emm", "666", "ddd")
    record <- assert(record, "test string vector", result, vec)

    result <- dbRun(conn, "`emm NULL `ddd")
    vec <- c("emm", NA, "ddd")
    record <- assert(record, "test string vector with NULL", result, vec)

    printer(record)
}
dbClose(conn)
