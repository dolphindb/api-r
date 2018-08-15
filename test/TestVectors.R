# 
#
# @Author -- Jingtang Zhang
# @Date   -- 2018.7.31, Hangzhou
# @Update -- 2018.8.15, Hangzhou
#
#

library("RDolphinDB")
conn <- dbConnect(DolphinDB(), "192.168.137.132", 8888)
if (conn@connected == TRUE) {

    ptm <- proc.time()
    testList <- list(c("hello", "my", "world"))
    result <- dbRpc(conn, "concat", testList)
    print(result)
    print(class(result))
    print(proc.time() - ptm)

    ptm <- proc.time()
    testList <- list(c("hello", NA, "world"))
    result <- dbRpc(conn, "concat", testList)
    print(result)
    print(class(result))
    print(proc.time() - ptm)

    ptm <- proc.time()
    testList <- list(c(2.5, 3.5, 6.55))
    result <- dbRpc(conn, "sum", testList)
    print(result)
    print(class(result))
    print(proc.time() - ptm)

    ptm <- proc.time()
    testList <- list(c(2.5, NA, 6.55))
    result <- dbRpc(conn, "sum", testList)
    print(result)
    print(class(result))
    print(proc.time() - ptm)

    ptm <- proc.time()
    testList <- list(c(TRUE, TRUE, FALSE))
    result <- dbRpc(conn, "sum", testList)
    print(result)
    print(class(result))
    print(proc.time() - ptm)

    ptm <- proc.time()
    testList <- list(c(TRUE, NA, FALSE))
    result <- dbRpc(conn, "sum", testList)
    print(result)
    print(class(result))
    print(proc.time() - ptm)

    ptm <- proc.time()
    testList <- list(c(1L, 2L, 3L))
    result <- dbRpc(conn, "sum", testList)
    print(result)
    print(class(result))
    print(proc.time() - ptm)

    ptm <- proc.time()
    testList <- list(c(1L, NA, 3L))
    result <- dbRpc(conn, "sum", testList)
    print(result)
    print(class(result))
    print(proc.time() - ptm)

    ptm <- proc.time()
    testList <- list(c(NA, NA, NA))
    result <- dbRpc(conn, "sum", testList)
    print(result)
    print(class(result))
    print(proc.time() - ptm)

    ptm <- proc.time()
    result <- dbRun(conn, "00f NULL NULL")
    print(result)
    print(class(result))
    print(proc.time() - ptm)

    ptm <- proc.time()
    result <- dbRun(conn, "true false true")
    print(result)
    print(class(result))
    print(proc.time() - ptm)

    ptm <- proc.time()
    result <- dbRun(conn, "sort(false true NULL)")
    print(result)
    print(class(result))
    print(proc.time() - ptm)

    ptm <- proc.time()
    result <- dbRun(conn, "5 6 7")
    print(result)
    print(class(result))
    print(proc.time() - ptm)

    ptm <- proc.time()
    result <- dbRun(conn, "sort(5 NULL 7)")
    print(result)
    print(class(result))
    print(proc.time() - ptm)

    ptm <- proc.time()
    result <- dbRun(conn, "3.5 9 6")
    print(result)
    print(class(result))
    print(proc.time() - ptm)

    ptm <- proc.time()
    result <- dbRun(conn, "3.5 9 NULL")
    print(result)
    print(class(result))
    print(proc.time() - ptm)

    ptm <- proc.time()
    result <- dbRun(conn, "`emm`666`ddd")
    print(result)
    print(class(result))
    print(proc.time() - ptm)

    ptm <- proc.time()
    result <- dbRun(conn, "`emm NULL `ddd")
    print(result)
    print(class(result))
    print(proc.time() - ptm)

}
dbClose(conn)
