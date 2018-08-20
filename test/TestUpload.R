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

    keys <- c("x", "y", "z")
    args <- list(5, c(2L, 3L), "666")
    stat <- dbUpload(conn, keys, args)
    if (stat) {
        result <- dbRun(conn, "x")
        scalar <- 5
        record <- assert(record, "test upload numeric", result, scalar)

        result <- dbRun(conn, "y")
        vec <- c(2L, 3L)
        record <- assert(record, "test upload vector", result, vec)

        result <- dbRun(conn, "z")
        scalar <- "666"
        record <- assert(record, "test upload string", result, scalar)
    }
    
    printer(record)
}
dbClose(conn)
