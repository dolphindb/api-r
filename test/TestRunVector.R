source("setup/Settings.R")
source("pub/Assert.R")

library(RDolphinDB)

conn <- dbConnect(DolphinDB(),HOST,PORT,USER,PASSWD)
if (conn@connected){
    record <- c(0L,0L)
    # bool
    result <- dbRun(conn,"[true,false,00b]")
    record <- assert(record,"download vector bool 1",result,c(TRUE,FALSE,NA))

    # char
    result <- dbRun(conn,"[0c,127c,00c]")
    record <- assert(record,"download vector char 1",result,c(0L,127L,NA))

    # short
    result <- dbRun(conn,"[0h,32767h,00h]")
    record <- assert(record,"download vector short 1",result,c(0L,32767L,NA))

    # int
    result <- dbRun(conn,"[0i,2147483647i,00i]")
    record <- assert(record,"download vector int 1",result,c(0L,2147483647L,NA))

    # long
    result <- dbRun(conn,"[0l,9223372036854775807l,00l]")
    record <- assert(record,"download vector long 1",result,c(0,9223372036854775807,NA))

    # date
    result <- dbRun(conn,"[1970.01.01d,00d]")
    record <- assert(record,"download vector date 1",result,c(as.Date("1970-01-01"),NA))

    # month
    result <- dbRun(conn,"[1970.01M,00M]")
    record <- assert(record,"download vector month 1",result,c(as.Date("1970-01-01"),NA))

    # time
    result <- dbRun(conn,"[13:30:10.008t,00t]")
    record <- assert(record,"download vector time 1",result,c(as.POSIXct("1970-01-01 13:30:10.008",tz="UTC"),as.POSIXct(NA,tz="UTC")))

    # minute
    result <- dbRun(conn,"[13:30m,00m]")
    record <- assert(record,"download vector minute 1",result,c(as.POSIXct("1970-01-01 13:30:00",tz="UTC"),as.POSIXct(NA,tz="UTC")))

    # second
    result <- dbRun(conn,"[13:30:10s,00s]")
    record <- assert(record,"download vector second 1",result,c(as.POSIXct("1970-01-01 13:30:10",tz="UTC"),as.POSIXct(NA,tz="UTC")))

    # datetime
    result <- dbRun(conn,"[2012.06.13T13:30:10D,00D]")
    record <- assert(record,"download vector datetime 1",result,c(as.POSIXct("2012-06-13 13:30:10",tz="UTC"),as.POSIXct(NA,tz="UTC")))

    # timestamp
    result <- dbRun(conn,"[2012.06.13T13:30:10.008T,00T]")
    record <- assert(record,"download vector timestamp 1",result,c(as.POSIXct("2012-06-13 13:30:10.008",tz="UTC"),as.POSIXct(NA,tz="UTC")))

    # nanotime
    result <- dbRun(conn,"[13:30:10.008007006n,00n]")
    record <- assert(record,"download vector nanotime 1",result,c(as.POSIXct("1970-01-01 13:30:10.008007006",tz="UTC"),as.POSIXct(NA,tz="UTC")))

    # nanotimestamp
    result <- dbRun(conn,"[2012.06.13T13:30:10.008007006N,00N]")
    record <- assert(record,"download vector nanotimestamp 1",result,c(as.POSIXct("2012-06-13 13:30:10.008007006",tz="UTC"),as.POSIXct(NA,tz="UTC")))

    # float
    result <- dbRun(conn,"[0.0f,float('nan'),float('inf'),00f]")
    record <- assert(record,"download vector float 1",result,c(0,NaN,Inf,NA))

    # double
    result <- dbRun(conn,"[0.0F,00F]")
    record <- assert(record,"download vector double 1",result,c(0,NA))

    # string
    result <- dbRun(conn,"[`a,\"\"]")
    record <- assert(record,"download vector string 1",result,c("a",NA))

    # symbol not support
    # result <- dbRun(conn,"symbol([`a,\"\"])")
    # record <- assert(record,"download vector symbol 1",result,c("a",""))

    # empty
    result <- dbRun(conn,"array(ANY)")
    record <- assert(record,"download vector empty 1",result,list())

    # any vector
    result <- dbRun(conn,"x=array(ANY).append!(1).append!(2020.01.01);x")
    record <- assert(record,"download vector any 1",result,list(1L,as.Date('2020-01-01')))

    printTestResult(record)
    conn <- dbClose(conn)
} else {
    stop("connect error in TestDownloadVector.R")
}