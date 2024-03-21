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

    mtx <- matrix(c(NA, NA, NA, NA, NA, NA), nrow=3, byrow=F)
    rownames(mtx) <- c("a", "b", "c")
    # colnames(mtx) <- c(2.5, 3.6)
    testList <- list(mtx)
    result <- dbRpc(conn, "sum", testList)
    vec <- as.numeric(c(NA, NA, NA))
    record <- assert(record, "test empty matrix rpc", result, vec)

    mtx <- matrix(c(1.5, 2.5, 3.5, NA, 5.5, 6.5), nrow=3, byrow=F)
    rownames(mtx) <- c("a", "b", "c")
    colnames(mtx) <- c(2.5, 3.6)
    testList <- list(mtx)
    print(testList)
    result <- dbRpc(conn, "sum", testList)
    vec <- c(1.5, 8.0, 10.0)
    record <- assert(record, "test numeric matrix rpc", result, vec)

    mtx <- matrix(c(1L, 2L, 3L, NA, 5L, 6L), nrow=3, byrow=F)
    rownames(mtx) <- c("a", "b", "c")
    colnames(mtx) <- c(2.5, 3.6)
    testList <- list(mtx)
    result <- dbRpc(conn, "sum", testList)
    vec <- c(1L, 7L, 9L)
    record <- assert(record, "test integer matrix rpc", result, vec)

    mtx <- matrix(c(TRUE, TRUE, FALSE, FALSE, FALSE, NA), nrow=3, byrow=F)
    rownames(mtx) <- c("a", "b", "c")
    colnames(mtx) <- c(2.5, 3.6)
    testList <- list(mtx)
    result <- dbRpc(conn, "sum", testList)
    vec <- c(1L, 1L, 0L)
    record <- assert(record, "test logical matrix rpc", result, vec)

    result <- dbRun(conn, "matrix(true true NULL, false false false)")
    mtx <- matrix(c(TRUE, TRUE, NA, FALSE, FALSE, FALSE), nrow=3, byrow=F)
    record <- assert(record, "test logical matrix with NULL", result, mtx)

    result <- dbRun(conn, "a = matrix(1 2 3, 4 5 6);a.rename!(`a`b`c, NULL 1.5);a")
    mtx <- matrix(c(1L, 2L, 3L, 4L, 5L, 6L), nrow=3, byrow=F)
    rownames(mtx) <- c("a", "b", "c")
    colnames(mtx) <- c(NA, 1.5)
    record <- assert(record, "test integer matrix with lable", result, mtx)

    result <- dbRun(conn, "matrix(1 NULL 3, 4 5 6)")
    mtx <- matrix(c(1L, NA, 3L, 4L, 5L, 6L), nrow=3, byrow=F)
    record <- assert(record, "test integer matrix with NULL", result, mtx)

    result <- dbRun(conn, "matrix(1.5 2.5 3.5, 4 5 6)")
    mtx <- matrix(c(1.5, 2.5, 3.5, 4, 5, 6), nrow=3, byrow=F)
    record <- assert(record, "test numeric matrix", result, mtx)

    result <- dbRun(conn, "matrix(1.5 2.5 3.5, 4 NULL 6)")
    mtx <- matrix(c(1.5, 2.5, 3.5, 4, NA, 6), nrow=3, byrow=F)
    record <- assert(record, "test numeric matrix with NULL", result, mtx)

    printer(record)
}
dbClose(conn)
