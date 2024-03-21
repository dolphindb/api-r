# 
#
# @Author -- Jingtang Zhang
# @Date   -- 2018.8.2, Hangzhou
# @Update -- 2018.8.19, Ningbo
#
#
source("Assert.R") 

library("RDolphinDB")
conn <- dbConnect(DolphinDB(), ip_addr, port)
if (conn@connected == TRUE) {

    record <- c(0L, 0L)

    keys <- c("x", "y", "za", "a", "b", "c", "d")

    dt <- as.POSIXct(c("2018-08-25 19:24:46"))

    date <- as.Date(c("2018-06-12","2018-07-22","2018-08-21"))

    table <- data.frame(
        date=as.Date(c("2018-06-12","2018-07-22","2018-08-21")),
        int=c(1L, 2L, NA),
        str=c("x", "dd", "z"),
        dbl=c(10.8, 7.6, 3.5),
        dt=as.POSIXct(c("2018-08-25 19:24:46","2018-08-25 19:24:47","2018-08-25 19:24:48")),
        stringsAsFactors=FALSE
    )

    table2 <- data.frame(
        d1 = 1L,
        d2 = "123",
        d3 = as.Date(c("2018-06-12")),
        d4 = as.POSIXct(c("2018-08-25 19:24:46")),
        d5 = 1.1, 
        stringsAsFactors=FALSE
    )

    args <- list(5, c(2L, 3L), "666", table, dt, date, table2)
    stat <- dbUpload(conn, keys, args)
    if (stat) {
        result <- dbRun(conn, "x")
        scalar <- 5
        print(result)
        record <- assert(record, "test upload numeric", result, scalar)

        # result <- dbRun(conn, "y")
        # vec <- c(2L, 3L)
        # record <- assert(record, "test upload vector", result, vec)

        # result <- dbRun(conn, "za")
        # scalar <- "666"
        # record <- assert(record, "test upload string", result, scalar)
        
        # result <- dbRun(conn, "a")
        # table <- data.frame(
        #     date=as.Date(c("2018-06-12","2018-07-22","2018-08-21")),
        #     int=c(1L, 2L, NA),
        #     str=c("x", "dd", "z"),
        #     dbl=c(10.8, 7.6, 3.5),
        #     dt=as.POSIXct(c("2018-08-25 19:24:46","2018-08-25 19:24:47","2018-08-25 19:24:48"))
        # )
        # record <- assert(record, "test upload data frame", result, table)

        # result <- dbRun(conn, "b")
        # record <- assert(record, "test upload datetime", result, dt)

        # result <- dbRun(conn, "c")
        # record <- assert(record, "test upload date", result, date)

        # result <- dbRun(conn, "d")
        # table2 <- data.frame(
        #     d1 = 1L,
        #     d2 = "123",
        #     d3 = as.Date(c("2018-06-12")),
        #     d4 = as.POSIXct(c("2018-08-25 19:24:46")),
        #     d5 = 1.1
        # )
        # record <- assert(record, "test single line table", result, table2)
    }
    
    print(record)
}
dbClose(conn)
