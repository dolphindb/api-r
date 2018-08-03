# 
#
# @Author -- Jingtang Zhang
# @Date   -- 2018.7.31, Hangzhou
# @Update -- 2018.8.1, Hangzhou
#
#

library("RDolphinDB")
conn <- dbConnect(DolphinDB(), "192.168.1.32", 8888)
if (conn@connected == TRUE) {

    ptm <- proc.time()
    mtx <- matrix(c(NA, NA, NA, NA, NA, NA), nrow=3, byrow=F)
    rownames(mtx) <- c("a", "b", "c")
    colnames(mtx) <- c(2.5, 3.6)
    testList <- list(mtx)
    result <- dbRpc(conn, "sum", testList)
    print(result)
    print(class(result))
    print(proc.time() - ptm)

    ptm <- proc.time()
    mtx <- matrix(c(1.5, 2.5, 3.5, NA, 5.5, 6.5), nrow=3, byrow=F)
    rownames(mtx) <- c("a", "b", "c")
    colnames(mtx) <- c(2.5, 3.6)
    testList <- list(mtx)
    result <- dbRpc(conn, "sum", testList)
    print(result)
    print(class(result))
    print(proc.time() - ptm)

    ptm <- proc.time()
    mtx <- matrix(c(1L, 2L, 3L, NA, 5L, 6L), nrow=3, byrow=F)
    rownames(mtx) <- c("a", "b", "c")
    colnames(mtx) <- c(2.5, 3.6)
    testList <- list(mtx)
    result <- dbRpc(conn, "sum", testList)
    print(result)
    print(class(result))
    print(proc.time() - ptm)

    ptm <- proc.time()
    mtx <- matrix(c(TRUE, TRUE, FALSE, FALSE, FALSE, NA), nrow=3, byrow=F)
    rownames(mtx) <- c("a", "b", "c")
    colnames(mtx) <- c(2.5, 3.6)
    testList <- list(mtx)
    result <- dbRpc(conn, "sum", testList)
    print(result)
    print(class(result))
    print(proc.time() - ptm)

    ptm <- proc.time()
    result <- dbRun(conn, "matrix(true true NULL, false false false)")
    print(result)
    print(class(result))
    print(proc.time() - ptm)

    ptm <- proc.time()
    result <- dbRun(conn, "a = matrix(1 2 3, 4 5 6);a.rename!(`a`b`c, NULL 1.5);a")
    print(result)
    print(class(result))
    print(proc.time() - ptm)

    ptm <- proc.time()
    result <- dbRun(conn, "matrix(1 NULL 3, 4 5 6)")
    print(result)
    print(class(result))
    print(proc.time() - ptm)

    ptm <- proc.time()
    result <- dbRun(conn, "matrix(1.5 2.5 3.5, 4 5 6)")
    print(result)
    print(class(result))
    print(proc.time() - ptm)

    ptm <- proc.time()
    result <- dbRun(conn, "matrix(1.5 2.5 3.5, 4 NULL 6)")
    print(result)
    print(class(result))
    print(proc.time() - ptm)

}
dbClose(conn)
