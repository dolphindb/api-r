# 
#
# @Author -- Jingtang Zhang
# @Date   -- 2018.8.1, Hangzhou
# @Update -- 2018.8.19, Ningbo
#
#

source("Assert.R")

library("RDolphinDB")
conn <- dbConnect(DolphinDB(), ip_addr, port)
if (conn@connected == TRUE) {

    record <- c(0L, 0L)

    result <- dbRun(conn, "(1, table(2018.07.22 2018.08.21 as date, `Hello`World as str), 5.5, 1 2 3, 2012.06M)")
    value_int <- 1L
    value_table <- data.frame(
        date = as.Date(c("2018-07-22", "2018-08-21")),
        str = as.character(c("Hello", "World"))
    )
    value_dbl <- 5.5
    value_vec <- c(1L, 2L, 3L)
    value_month <- as.Date("2012-06-01")
    record <- assert(record, "test anyvector", result, list(value_int, value_table, value_dbl, value_vec, value_month))
    
    printer(record)
}
dbClose(conn)
