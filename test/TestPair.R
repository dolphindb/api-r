# 
#
# @Author -- Jingtang Zhang
# @Date   -- 2018.8.17, Hangzhou
# @Update -- 2018.8.19, Ningbo
#
#

source("Assert.R")

library("RDolphinDB")
conn <- dbConnect(DolphinDB(), ip_addr, port)
if (conn@connected == TRUE) {

    record <- c(0L, 0L)
  
    result <- dbRun(conn, "4:8")
    vec <- c(4L, 8L)
    record <- assert(record, "test integer pair", result, vec)
    
    result <- dbRun(conn, "3.5:6.8")
    vec <- c(3.5, 6.8)
    record <- assert(record, "test numeric pair", result, vec)

    result <- dbRun(conn, "`Hello:`World")
    vec <- c("Hello", "World")
    record <- assert(record, "test character pair", result, vec)
    
    printer(record)
}
dbClose(conn)
