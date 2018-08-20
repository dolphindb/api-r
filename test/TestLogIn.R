# 
#
# @Author -- Jingtang Zhang
# @Date   -- 2018.8.2, Hangzhou
# @Update -- 2018.8.19, Ningbo
#
#

source("Assert.R")

library("RDolphinDB")
conn <- dbConnect(DolphinDB(), ip_addr, port, "admin", "123456")
if (conn@connected == TRUE) {

    record <- c(0L, 0L)
    
    record <- assert(record, "test log in", 1L, 1L)

    printer(record)
}
dbClose(conn)
