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
    testList <- list("hello", "world")
    result <- dbRpc(conn, "concat", testList)
    print(result)
    print(class(result))
    print(proc.time() - ptm)

    ptm <- proc.time()
    testList <- list(16L)
    result <- dbRpc(conn, "sum", testList)
    print(result)
    print(class(result))
    print(proc.time() - ptm)

    ptm <- proc.time()
    testList <- list(TRUE)
    result <- dbRpc(conn, "sum", testList)
    print(result)
    print(class(result))
    print(proc.time() - ptm)

    ptm <- proc.time()
    testList <- list(NA)
    result <- dbRpc(conn, "sum", testList)
    print(result)
    print(class(result))
    print(proc.time() - ptm)

    ptm <- proc.time()
    testList <- list(25.6)
    result <- dbRpc(conn, "sum", testList)
    print(result)
    print(class(result))
    print(proc.time() - ptm)

    ptm <- proc.time()
    testList <- list("hello Rcpp")
    result <- dbRpc(conn, "sum", testList)
    print(result)
    print(class(result))
    print(proc.time() - ptm)

    ptm <- proc.time()
    result <- dbRun(conn, "00h")
    print(result)
    print(class(result))
    print(proc.time() - ptm)

    ptm <- proc.time()
    result <- dbRun(conn, "00l")
    print(result)
    print(class(result))
    print(proc.time() - ptm)

    ptm <- proc.time()
    result <- dbRun(conn, "00b")
    print(result)
    print(class(result))
    print(proc.time() - ptm)

    ptm <- proc.time()
    result <- dbRun(conn, "00i")
    print(result)
    print(class(result))
    print(proc.time() - ptm)

    ptm <- proc.time()
    result <- dbRun(conn, "00f")
    print(result)
    print(class(result))
    print(proc.time() - ptm)

    ptm <- proc.time()
    result <- dbRun(conn, "false")
    print(result)
    print(class(result))
    print(proc.time() - ptm)

    ptm <- proc.time()
    result <- dbRun(conn, "2.5")
    print(result)
    print(class(result))
    print(proc.time() - ptm)

    ptm <- proc.time()
    result <- dbRun(conn, "`hello")
    print(result)
    print(class(result))
    print(proc.time() - ptm)

    ptm <- proc.time()
    result <- dbRun(conn, "16")
    print(result)
    print(class(result))
    print(proc.time() - ptm)

    ptm <- proc.time()
    result <- dbRun(conn, "NULL")
    print(result)
    print(class(result))
    print(proc.time() - ptm)

}
dbClose(conn)
