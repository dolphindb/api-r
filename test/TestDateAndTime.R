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
    testList <- list(as.POSIXct(c("2018-07-22 02:30:32", "2018-08-21 03:15:26", NA)))
    result <- dbRpc(conn, "size", testList)
    print(result)
    print(class(result))
    print(proc.time() - ptm)

    ptm <- proc.time()
    testList <- list(as.Date(c("2018-07-22", "2018-08-21", NA)))
    result <- dbRpc(conn, "size", testList)
    print(result)
    print(class(result))
    print(proc.time() - ptm)

    ptm <- proc.time()
    testList <- list(as.POSIXct("2018-07-22 02:30:32"), 20L, "h")
    result <- dbRpc(conn, "temporalAdd", testList)
    print(result)
    print(class(result))
    print(proc.time() - ptm)

    ptm <- proc.time()
    testList <- list(as.Date("2018-07-22"), 1L, "w")
    result <- dbRpc(conn, "temporalAdd", testList)
    print(result)
    print(class(result))
    print(proc.time() - ptm)

    ptm <- proc.time()
    result <- dbRun(conn, "matrix(2018.07.06 00:01:01 2018.08.21 06:00:00, 2018.09.30 15:26:14 2018.02.18 13:36:20, NULL 2015.06.09 11:32:36)")
    print(result)
    print(class(result))
    print(proc.time() - ptm)

    ptm <- proc.time()
    result <- dbRun(conn, "matrix(2018.07.06 2018.08.21, 2018.09.30 2018.02.18, NULL 2015.06.09)")
    print(result)
    print(class(result))
    print(proc.time() - ptm)

    ptm <- proc.time()
    result <- dbRun(conn, "2018.07.06 00:01:01 NULL 2018.09.30 03:29:56")
    print(result)
    print(class(result))
    print(proc.time() - ptm)

    ptm <- proc.time()
    result <- dbRun(conn, "2018.07.06 NULL 2018.09.30")
    print(result)
    print(class(result))
    print(proc.time() - ptm)

    ptm <- proc.time()
    result <- dbRun(conn, "2018.07.06 12:01:01")
    print(result)
    print(class(result))
    print(proc.time() - ptm)

    ptm <- proc.time()
    result <- dbRun(conn, "2018.07.06")
    print(result)
    print(class(result))
    print(proc.time() - ptm)

}
dbClose(conn)
