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
    result <- dbRun(conn, "matrix(2018.08.14T16:16:16.016147852 2018.08.17T03:26:56.088985651, 2018.08.25T19:24:46.832147524 2018.08.25T19:24:46.832369852, NULL 2018.08.25T19:24:46.832025741)")
    print(result)
    print(class(result))
    print(proc.time() - ptm)
    
    ptm <- proc.time()
    result <- dbRun(conn, "2018.08.14T16:16:16.016014785 2018.08.17T03:26:56.088036985 2018.08.25T19:24:46.832002147")
    print(result)
    print(class(result))
    print(proc.time() - ptm)
    
    ptm <- proc.time()
    result <- dbRun(conn, "2018.08.14T16:16:16.016023654")
    print(result)
    print(class(result))
    print(proc.time() - ptm)
  
    ptm <- proc.time()
    result <- dbRun(conn, "matrix(16:16:16.016147852 16:16:16.016023698, 16:16:17.016741258 16:26:16.016256931, NULL 19:16:16.016147013)")
    print(result)
    print(class(result))
    print(proc.time() - ptm)
    
    ptm <- proc.time()
    result <- dbRun(conn, "16:16:16.016152266 16:16:17.017214785 16:16:18.018369874")
    print(result)
    print(class(result))
    print(proc.time() - ptm)
    
    ptm <- proc.time()
    result <- dbRun(conn, "16:16:16.016265874")
    print(result)
    print(class(result))
    print(proc.time() - ptm)
  
    ptm <- proc.time()
    result <- dbRun(conn, "matrix(2018.08.14T16:16:16.016 2018.08.17T03:26:56.088, 2018.08.25T19:24:46.832 2018.08.25T19:24:46.832, NULL 2018.08.25T19:24:46.832)")
    print(result)
    print(class(result))
    print(proc.time() - ptm)
    
    ptm <- proc.time()
    result <- dbRun(conn, "2018.08.14T16:16:16.016 2018.08.17T03:26:56.088 2018.08.25T19:24:46.832")
    print(result)
    print(class(result))
    print(proc.time() - ptm)
    
    ptm <- proc.time()
    result <- dbRun(conn, "2018.08.14T16:16:16.016")
    print(result)
    print(class(result))
    print(proc.time() - ptm)
  
    ptm <- proc.time()
    result <- dbRun(conn, "matrix(16:16:16 16:16:15, 16:17:16 16:18:16, NULL 19:16:16)")
    print(result)
    print(class(result))
    print(proc.time() - ptm)
    
    ptm <- proc.time()
    result <- dbRun(conn, "16:16:16 16:17:16 16:18:16")
    print(result)
    print(class(result))
    print(proc.time() - ptm)
    
    ptm <- proc.time()
    result <- dbRun(conn, "16:16:16")
    print(result)
    print(class(result))
    print(proc.time() - ptm)
  
    ptm <- proc.time()
    result <- dbRun(conn, "matrix(16:16m 16:16m, 16:17m 16:18m, NULL 19:16m)")
    print(result)
    print(class(result))
    print(proc.time() - ptm)
    
    ptm <- proc.time()
    result <- dbRun(conn, "16:16m 16:17m 16:18m")
    print(result)
    print(class(result))
    print(proc.time() - ptm)
    
    ptm <- proc.time()
    result <- dbRun(conn, "16:16m")
    print(result)
    print(class(result))
    print(proc.time() - ptm)
  
    ptm <- proc.time()
    result <- dbRun(conn, "matrix(16:16:16.016 16:16:16.016, 16:16:17.016 16:26:16.016, NULL 19:16:16.016)")
    print(result)
    print(class(result))
    print(proc.time() - ptm)
    
    ptm <- proc.time()
    result <- dbRun(conn, "16:16:16.016 16:16:17.017 16:16:18.018")
    print(result)
    print(class(result))
    print(proc.time() - ptm)
    
    ptm <- proc.time()
    result <- dbRun(conn, "16:16:16.016")
    print(result)
    print(class(result))
    print(proc.time() - ptm)
  
    ptm <- proc.time()
    result <- dbRun(conn, "matrix(2018.07M 2018.08M, 2018.09M 2018.02M, NULL 2015.06M)")
    print(result)
    print(class(result))
    print(proc.time() - ptm)
  
    ptm <- proc.time()
    result <- dbRun(conn, "2018.07M 2018.08M 2018.09M")
    print(result)
    print(class(result))
    print(proc.time() - ptm)
  
    ptm <- proc.time()
    result <- dbRun(conn, "2018.07M")
    print(result)
    print(class(result))
    print(proc.time() - ptm)

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
