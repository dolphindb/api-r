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

    result <- dbRun(conn, "set(1 1.5 2 2.5 2 2.50 2.500 00f NULL)")
    set <- c(2.5, 2.0, NA, 1.5, 1.0)
    record <- assert(record, "test set", result, set)
    
    printer(record)
}
dbClose(conn)
