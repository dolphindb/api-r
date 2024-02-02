source("Assert.R")

library(RDolphinDB)

conn <- dbConnect(DolphinDB(),"192.168.0.54",8849,"admin","123456")
if (conn@connected){
    result <- dbRun(conn,"table([00c,1c,0c] as t_char,[00h,1h,0h] as t_short,[00i,1i,0i] as t_int,[00l,1l,0l] as t_long)")
    table <- data.frame(
        t_char = c(NA,1,0),
        t_short = c(NA,1,0),
        t_int = c(NA,1,0),
        t_long = c(NA,1L,0L)
    )
    record <- c(0,0)
    record <- assert(record, "test dataframe run", result, table)
    print(record)

    result <- dbRun(conn,"table(`a`b`c as t_str)")
    print(result)
    print(class(result$t_str))
}
dbClose(conn)