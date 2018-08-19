# 
#
# @Author -- Jingtang Zhang
# @Date   -- 2018.8.2, Hangzhou
# @Update -- 2018.8.19, Ningbo
#
#

library("RDolphinDB")
conn <- dbConnect(DolphinDB(), "192.168.137.132", 8888, "admin", "123456")
if (conn@connected == TRUE) {

    source("Assert.R")
    record <- c(0L, 0L)
    
    record <- assert(record, "test log in", 1L, 1L)
    printer(record)

}
dbClose(conn)
