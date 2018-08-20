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

    testList <- list("hello", "world")
    result <- dbRpc(conn, "concat", testList)
    scalar <- "helloworld"
    record <- assert(record, "test character scalar rpc", result, scalar)

    testList <- list(16L)
    result <- dbRpc(conn, "sum", testList)
    scalar <- 16L
    record <- assert(record, "test integer scalar rpc", result, scalar)

    testList <- list(TRUE)
    result <- dbRpc(conn, "sum", testList)
    scalar <- TRUE
    record <- assert(record, "test logical scalar rpc", result, scalar)

    testList <- list(NA)
    result <- dbRpc(conn, "sum", testList)
    scalar <- NA
    record <- assert(record, "test NULL scalar rpc", result, scalar)

    testList <- list(25.6)
    result <- dbRpc(conn, "sum", testList)
    scalar <- 25.6
    record <- assert(record, "test numeric scalar rpc", result, scalar)

    testList <- list("hello Rcpp")
    result <- dbRpc(conn, "sum", testList)
    scalar <- "hello Rcpp"
    record <- assert(record, "test character scalar rpc", result, scalar)

    result <- dbRun(conn, "00h")
    scalar <- NA
    record <- assert(record, "test short NULL scalar", result, scalar)

    result <- dbRun(conn, "00l")
    scalar <- NA
    record <- assert(record, "test long NULL scalar", result, scalar)

    result <- dbRun(conn, "00b")
    scalar <- NA
    record <- assert(record, "test bool NULL scalar", result, scalar)

    result <- dbRun(conn, "00i")
    scalar <- as.integer(NA)
    record <- assert(record, "test int NULL scalar", result, scalar)

    result <- dbRun(conn, "00f")
    scalar <- NA
    record <- assert(record, "test float NULL scalar", result, scalar)
    
    result <- dbRun(conn, "00c")
    scalar <- NA
    record <- assert(record, "test character NULL scalar", result, scalar)

    result <- dbRun(conn, "false")
    scalar <- FALSE 
    record <- assert(record, "test logical scalar", result, scalar)

    result <- dbRun(conn, "2.5")
    scalar <- 2.5
    record <- assert(record, "test double scalar", result, scalar)

    result <- dbRun(conn, "2.5f")
    scalar <- 2.5
    record <- assert(record, "test float scalar", result, scalar)

    result <- dbRun(conn, "`hello")
    scalar <- "hello"
    record <- assert(record, "test string scalar", result, scalar)
    
    result <- dbRun(conn, "'a'")
    scalar <- "a"
    record <- assert(record, "test character scalar", result, scalar)

    result <- dbRun(conn, "16")
    scalar <- 16L
    record <- assert(record, "test integer scalar", result, scalar)

    result <- dbRun(conn, "NULL")
    scalar <- NA
    record <- assert(record, "test NULL scalar", result, scalar)

    printer(record)
}
dbClose(conn)
