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
    
    result <- dbRun(conn, "matrix(2018.08.14T16:16:16.016147852 2018.08.17T03:26:56.088985651, 2018.08.25T19:24:46.832147524 2018.08.25T19:24:46.832369852, NULL 2018.08.25T19:24:46.832025741)")
    mtx <- matrix(
        c(
            "2018-08-14 16:16:16",
            "2018-08-17 03:26:56",
            "2018-08-25 19:24:46",
            "2018-08-25 19:24:46",
            NA,
            "2018-08-25 19:24:46"
        ), nrow=2, byrow=F
    )
    record <- assert(record, "test nanotimestamp matrix", result, mtx)
    
    result <- dbRun(conn, "2018.08.14T16:16:16.016014785 2018.08.17T03:26:56.088036985 2018.08.25T19:24:46.832002147")
    vec <- as.POSIXct(c("2018-08-14 16:16:16.016014785", "2018-08-17 03:26:56.088036985", "2018-08-25 19:24:46.832002147"), tz="UTC")
    record <- assert(record, "test nanotimestamp vector", result, vec)

    result <- dbRun(conn, "2018.08.14T16:16:16.016023654")
    scalar <- as.POSIXct("2018-08-14 16:16:16.016023654",tz="UTC")
    record <- assert(record, "test nanotimestamp scalar", result, scalar)
    
    result <- dbRun(conn, "matrix(16:16:16.016147852 16:16:16.016023698, 16:16:17.016741258 16:26:16.016256931, NULL 19:16:16.016147013)")
    mtx <- matrix(
        c(
            "1970-01-01 16:16:16",
            "1970-01-01 16:16:16",
            "1970-01-01 16:16:17",
            "1970-01-01 16:26:16",
            NA,
            "1970-01-01 19:16:16"
        ), nrow=2, byrow=F
    )
    record <- assert(record, "test nanotime matrix", result, mtx)
    
    result <- dbRun(conn, "16:16:16.016152266 16:16:17.017214785 16:16:18.018369874")
    vec <- as.POSIXct(c("1970-01-01 16:16:16.016152266", "1970-01-01 16:16:17.017214785", "1970-01-01 16:16:18.018369874"),tz="UTC")
    record <- assert(record, "test nanotime vector", result, vec)
    
    result <- dbRun(conn, "16:16:16.016265874")
    scalar <- as.POSIXct("1970-01-01 16:16:16.016265874",tz="UTC")
    record <- assert(record, "test nanotime scalar", result, scalar)
  
    result <- dbRun(conn, "matrix(2018.08.14T16:16:16.016 2018.08.17T03:26:56.088, 2018.08.25T19:24:46.832 2018.08.25T19:24:46.832, NULL 2018.08.25T19:24:46.832)")
    mtx <- matrix(
        c(
            "2018-08-14 16:16:16",
            "2018-08-17 03:26:56",
            "2018-08-25 19:24:46",
            "2018-08-25 19:24:46",
            NA,
            "2018-08-25 19:24:46"
        ), nrow=2, byrow=F
    )
    record <- assert(record, "test timestamp matrix", result, mtx)
    
    result <- dbRun(conn, "2018.08.14T16:16:16.016 2018.08.17T03:26:56.088 2018.08.25T19:24:46.832")
    vec <- as.POSIXct(c("2018-08-14 16:16:16.016", "2018-08-17 03:26:56.088", "2018-08-25 19:24:46.832"),tz="UTC")
    record <- assert(record, "test timestamp vector", result, vec)
    
    result <- dbRun(conn, "2018.08.14T16:16:16.016")
    scalar <- as.POSIXct("2018-08-14 16:16:16.016",tz="UTC")
    record <- assert(record, "test timestamp scalar", result, scalar)

    result <- dbRun(conn, "matrix(16:16:16 16:16:15, 16:17:16 16:18:16, NULL 19:16:16)")
    mtx <- matrix(
        c(
            "1970-01-01 16:16:16",
            "1970-01-01 16:16:15",
            "1970-01-01 16:17:16",
            "1970-01-01 16:18:16",
            NA,
            "1970-01-01 19:16:16"
        ), nrow=2, byrow=F
    )
    record <- assert(record, "test second matrix", result, mtx)
    
    result <- dbRun(conn, "16:16:16 16:17:16 16:18:16")
    vec <- as.POSIXct(c("1970-01-01 16:16:16", "1970-01-01 16:17:16", "1970-01-01 16:18:16"),tz="UTC")
    record <- assert(record, "test second vector", result, vec)
    
    result <- dbRun(conn, "16:16:16")
    scalar <- as.POSIXct("1970-01-01 16:16:16",tz="UTC")
    record <- assert(record, "test second scalar", result, scalar)
  
    result <- dbRun(conn, "matrix(16:16m 16:16m, 16:17m 16:18m, NULL 19:16m)")
    mtx <- matrix(
        c(
            "1970-01-01 16:16:00",
            "1970-01-01 16:16:00",
            "1970-01-01 16:17:00",
            "1970-01-01 16:18:00",
            NA,
            "1970-01-01 19:16:00"
        ), nrow=2, byrow=F
    )
    record <- assert(record, "test minute matrix", result, mtx)
    
    result <- dbRun(conn, "16:16m 16:17m 16:18m")
    vec <- as.POSIXct(c("1970-01-01 16:16:00", "1970-01-01 16:17:00", "1970-01-01 16:18:00"),tz="UTC")
    record <- assert(record, "test minute vector", result, vec)
    
    result <- dbRun(conn, "16:16m")
    scalar <- as.POSIXct("1970-01-01 16:16:00",tz="UTC")
    record <- assert(record, "test minute scalar", result, scalar)
  
    result <- dbRun(conn, "matrix(16:16:16.016 16:16:16.016, 16:16:17.016 16:26:16.016, NULL 19:16:16.016)")
    mtx <- matrix(
        c(
            "1970-01-01 16:16:16",
            "1970-01-01 16:16:16",
            "1970-01-01 16:16:17",
            "1970-01-01 16:26:16",
            NA,
            "1970-01-01 19:16:16"
        ), nrow=2, byrow=F
    )
    record <- assert(record, "test time matrix", result, mtx)
    
    result <- dbRun(conn, "16:16:16.016 16:16:17.017 16:16:18.018")
    vec <- as.POSIXct(c("1970-01-01 16:16:16.016", "1970-01-01 16:16:17.017", "1970-01-01 16:16:18.018"),tz="UTC")
    record <- assert(record, "test time vector", result, vec)
    
    result <- dbRun(conn, "16:16:16.016")
    scalar <- as.POSIXct("1970-01-01 16:16:16.016",tz="UTC")
    record <- assert(record, "test time scalar", result, scalar)
  
    result <- dbRun(conn, "matrix(2018.07M 2018.08M, 2018.09M 2018.02M, NULL 2015.06M)")
    mtx <- matrix(
        c(
            "2018-07-01",
            "2018-08-01",
            "2018-09-01",
            "2018-02-01",
            NA,
            "2015-06-01"
        ), nrow=2, byrow=F
    )
    record <- assert(record, "test month matrix", result, mtx)

    result <- dbRun(conn, "2018.07M 2018.08M 2018.09M")
    vec <- as.Date(c("2018-07-01", "2018-08-01", "2018-09-01"))
    record <- assert(record, "test month vector", result, vec)

    result <- dbRun(conn, "2018.07M")
    scalar <- as.Date("2018-07-01")
    record <- assert(record, "test month, scalar", result, scalar)

    ## testList <- list(as.POSIXct(c("2018-07-22 02:30:32", "2018-08-21 03:15:26", NA),tz="UTC"))
    ## result <- dbRpc(conn, "size", testList)
    ## scalar <- 3L
    ## record <- assert(record, "test datetime rpc", result, scalar)

    ## testList <- list(as.Date(c("2018-07-22", "2018-08-21", NA)))
    ## result <- dbRpc(conn, "size", testList)
    ## scalar <- 3L
    ## record <- assert(record, "test date rpc", result, scalar)

    testList <- list(as.POSIXct("2018-07-22 02:30:32"), 20L, "h")
    result <- dbRpc(conn, "temporalAdd", testList)
    scalar <- as.POSIXct("2018-07-22 22:30:32")
    record <- assert(record, "test datetime add", result, scalar)

    testList <- list(as.Date("2018-07-22"), 1L, "w")
    result <- dbRpc(conn, "temporalAdd", testList)
    scalar <- as.Date("2018-07-29")
    record <- assert(record, "test date add", result, scalar)

    result <- dbRun(conn, "matrix(2018.07.06 00:01:01 2018.08.21 06:00:00, 2018.09.30 15:26:14 2018.02.18 13:36:20, NULL 2015.06.09 11:32:36)")
    mtx <- matrix(
        c(
            "2018-07-06 00:01:01",
            "2018-08-21 06:00:00",
            "2018-09-30 15:26:14",
            "2018-02-18 13:36:20",
            NA,
            "2015-06-09 11:32:36"
        ), nrow=2, byrow=F
    )
    record <- assert(record, "test datetime matrix", result, mtx)

    result <- dbRun(conn, "matrix(2018.07.06 2018.08.21, 2018.09.30 2018.02.18, NULL 2015.06.09)")
    mtx <- matrix(
        c(
            "2018-07-06",
            "2018-08-21",
            "2018-09-30",
            "2018-02-18",
            NA,
            "2015-06-09"
        ), nrow=2, byrow=F
    )
    record <- assert(record, "test date matrix", result, mtx)

    result <- dbRun(conn, "2018.07.06 00:01:01 NULL 2018.09.30 03:29:56")
    vec <- as.POSIXct(c("2018-07-06 00:01:01", NA, "2018-09-30 03:29:56"),tz="UTC")
    record <- assert(record, "test datetime vector", result, vec)

    result <- dbRun(conn, "2018.07.06 NULL 2018.09.30")
    vec <- as.Date(c("2018-07-06", NA, "2018-09-30"))
    record <- assert(record, "test date vector", result, vec)

    result <- dbRun(conn, "2018.07.06 12:01:01")
    scalar <- as.POSIXct("2018-07-06 12:01:01",tz="UTC")
    record <- assert(record, "test datetime scalar", result, scalar)

    result <- dbRun(conn, "2018.07.06")
    scalar <- as.Date("2018-07-06")
    record <- assert(record, "test date scalar", result, scalar)
    
    printer(record)
}
dbClose(conn)
