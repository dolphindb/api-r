source("setup/Settings.R")
source("pub/Assert.R")

library(RDolphinDB)

conn <- dbConnect(DolphinDB(),HOST,PORT,USER,PASSWD)
if (conn@connected){
    record <- c(0L,0L)
    # char
    result <- dbRun(conn,"set([0c,127c,00c])")
    record <- assert(record,"download set char 1",result,c(0L,127L,NA),mode="in")

    # short
    result <- dbRun(conn,"set([0h,32767h,00h])")
    record <- assert(record,"download set short 1",result,c(0L,32767L,NA),mode="in")

    # int
    result <- dbRun(conn,"set([0i,2147483647i,00i])")
    record <- assert(record,"download set int 1",result,c(0L,2147483647L,NA),mode="in")

    # long
    result <- dbRun(conn,"set([0l,9223372036854775807l,00l])")
    record <- assert(record,"download set long 1",result,c(0L,9223372036854775807,NA),mode="in")

    # date
    result <- dbRun(conn,"set([1970.01.01d,00d])")
    record <- assert(record,"download set date 1",result,c(as.Date("1970-01-01"),NA),mode="in")

    # month
    result <- dbRun(conn,"set([1970.01M,00M])")
    record <- assert(record,"download set month 1",result,c(as.Date("1970-01-01"),NA),mode="in")

    # time
    result <- dbRun(conn,"set([13:30:10.008t,00t])")
    record <- assert(record,"download set time 1",result,c(as.POSIXct("1970-01-01 13:30:10.008",tz="UTC"),as.POSIXct(NA,tz="UTC")),mode="in")

    # minute
    result <- dbRun(conn,"set([13:30m,00m])")
    record <- assert(record,"download set minute 1",result,c(as.POSIXct("1970-01-01 13:30:00",tz="UTC"),as.POSIXct(NA,tz="UTC")),mode="in")

    # second
    result <- dbRun(conn,"set([13:30:10s,00s])")
    record <- assert(record,"download set second 1",result,c(as.POSIXct("1970-01-01 13:30:10",tz="UTC"),as.POSIXct(NA,tz="UTC")),mode="in")

    # datetime
    result <- dbRun(conn,"set([2012.06.13T13:30:10D,00D])")
    record <- assert(record,"download set datetime 1",result,c(as.POSIXct("2012-06-13 13:30:10",tz="UTC"),as.POSIXct(NA,tz="UTC")),mode="in")

    # timestamp
    result <- dbRun(conn,"set([2012.06.13T13:30:10.008T,00T])")
    record <- assert(record,"download set timestamp 1",result,c(as.POSIXct("2012-06-13 13:30:10.008",tz="UTC"),as.POSIXct(NA,tz="UTC")),mode="in")

    # nanotime
    result <- dbRun(conn,"set([13:30:10.008007006n,00n])")
    record <- assert(record,"download set nanotime 1",result,c(as.POSIXct("1970-01-01 13:30:10.008007006",tz="UTC"),as.POSIXct(NA,tz="UTC")),mode="in")

    # nanotimestamp
    result <- dbRun(conn,"set([2012.06.13T13:30:10.008007006N,00N])")
    record <- assert(record,"download set nanotimestamp 1",result,c(as.POSIXct("2012-06-13 13:30:10.008007006",tz="UTC"),as.POSIXct(NA,tz="UTC")),mode="in")

    # float
    result <- dbRun(conn,"set([0.0f,float('nan'),float('inf'),00f])")
    record <- assert(record,"download set float 1",result,c(0,NaN,Inf,NA),mode="in")

    # double
    result <- dbRun(conn,"set([0.0F,00F])")
    record <- assert(record,"download set double 1",result,c(0,NA),mode="in")

    # string
    result <- dbRun(conn,"set([`a,\"\"])")
    record <- assert(record,"download set string 1",result,c("a",NA),mode="in")

    # empty
    result <- dbRun(conn,"set(array(INT))")
    record <- assert(record,"download set empty 1",result,as.integer(c()),mode="in")

    printTestResult(record)
    conn <- dbClose(conn)
} else {
    stop("connect error in TestDownloadSet.R")
}