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

    table <- data.frame(id=c(1,2,3), value=c(2.5, 3.5, 5.5))
    clm <- 1L
    row <- 1L
    testList <- list(table, clm, row)
    result <- dbRpc(conn, "cell", testList)
    record <- assert(record, "test dataframe rpc", result, 3.5)

    result <- dbRun(conn, "table(2018.06.12 2018.07.22 2018.08.21 as date, 1 2 NULL as int, `x`dd`zz as str, 10.8 7.6 3.5 as dbl)")
    table <- data.frame(
        date=as.Date(c("2018-06-12","2018-07-22","2018-08-21")),
        int=c(1L, 2L, NA),
        str=c("x", "dd", "zz"),
        dbl=c(10.8, 7.6, 3.5)
    )
    record <- assert(record, "test dataframe run", result, table)
    
    printer(record)

}
dbClose(conn)
