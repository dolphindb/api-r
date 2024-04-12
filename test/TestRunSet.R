source("setup/Settings.R")
source("pub/Assert.R")

library(RDolphinDB)

conn <- dbConnect(DolphinDB(),HOST,PORT,USER,PASSWD)
if (conn@connected){
    record <- c(0L,0L)
    # char
    result <- dbRun(conn,"set([0c,127c,00c])")
    record <- assert(record,"download set char set([0c,127c,00c])",result,c(0L,127L,NA_integer_),mode="in")
    result <- dbRun(conn,"set(array(CHAR))")
    record <- assert(record,"download set char empty",result,integer(0))

    # short
    result <- dbRun(conn,"set([0h,32767h,00h])")
    record <- assert(record,"download set short set([0h,32767h,00h])",result,c(0L,32767L,NA_integer_),mode="in")
    result <- dbRun(conn,"set(array(SHORT))")
    record <- assert(record,"download set short empty",result,integer(0))

    # int
    result <- dbRun(conn,"set([0i,2147483647i,00i])")
    record <- assert(record,"download set int set([0i,2147483647i,00i])",result,c(0L,2147483647L,NA_integer_),mode="in")
    result <- dbRun(conn,"set(array(INT))")
    record <- assert(record,"download set int empty",result,integer(0))

    # long
    result <- dbRun(conn,"set([0l,9223372036854775807l,00l])")
    record <- assert(record,"download set long set([0l,9223372036854775807l,00l])",result,c(0L,9223372036854775807,NA_real_),mode="in")
    result <- dbRun(conn,"set(array(LONG))")
    record <- assert(record,"download set long empty",result,numeric(0))

    # date
    result <- dbRun(conn,"set([1970.01.01d,00d])")
    record <- assert(record,"download set date set([1970.01.01d,00d])",result,c(as.Date("1970-01-01"),NA),mode="in")
    result <- dbRun(conn,"set(array(DATE))")
    record <- assert(record,"download set date empty",result,as.Date(c()))

    # month
    result <- dbRun(conn,"set([1970.01M,00M])")
    record <- assert(record,"download set month set([1970.01M,00M])",result,c(as.Date("1970-01-01"),NA),mode="in")
    result <- dbRun(conn,"set(array(MONTH))")
    record <- assert(record,"download set month empty",result,as.Date(c()))

    # time
    result <- dbRun(conn,"set([13:30:10.008t,00t])")
    record <- assert(record,"download set time set([13:30:10.008t,00t])",result,c(as.POSIXct("1970-01-01 13:30:10.008",tz="UTC"),as.POSIXct(NA,tz="UTC")),mode="in")
    result <- dbRun(conn,"set(array(TIME))")
    record <- assert(record,"download set time empty",result,as.POSIXct(c(),tz="UTC"))

    # minute
    result <- dbRun(conn,"set([13:30m,00m])")
    record <- assert(record,"download set minute set([13:30m,00m])",result,c(as.POSIXct("1970-01-01 13:30:00",tz="UTC"),as.POSIXct(NA,tz="UTC")),mode="in")
    result <- dbRun(conn,"set(array(MINUTE))")
    record <- assert(record,"download set minute empty",result,as.POSIXct(c(),tz="UTC"))

    # second
    result <- dbRun(conn,"set([13:30:10s,00s])")
    record <- assert(record,"download set second set([13:30:10s,00s])",result,c(as.POSIXct("1970-01-01 13:30:10",tz="UTC"),as.POSIXct(NA,tz="UTC")),mode="in")
    result <- dbRun(conn,"set(array(MINUTE))")
    record <- assert(record,"download set second empty",result,as.POSIXct(c(),tz="UTC"))

    # datetime
    result <- dbRun(conn,"set([2012.06.13T13:30:10D,00D])")
    record <- assert(record,"download set datetime set([2012.06.13T13:30:10D,00D])",result,c(as.POSIXct("2012-06-13 13:30:10",tz="UTC"),as.POSIXct(NA,tz="UTC")),mode="in")
    result <- dbRun(conn,"set(array(DATETIME))")
    record <- assert(record,"download set datetime empty",result,as.POSIXct(c(),tz="UTC"))

    # timestamp
    result <- dbRun(conn,"set([2012.06.13T13:30:10.008T,00T])")
    record <- assert(record,"download set timestamp set([2012.06.13T13:30:10.008T,00T])",result,c(as.POSIXct("2012-06-13 13:30:10.008",tz="UTC"),as.POSIXct(NA,tz="UTC")),mode="in")
    result <- dbRun(conn,"set(array(TIMESTAMP))")
    record <- assert(record,"download set timestamp empty",result,as.POSIXct(c(),tz="UTC"))

    # nanotime
    result <- dbRun(conn,"set([13:30:10.008007006n,00n])")
    record <- assert(record,"download set nanotime set([13:30:10.008007006n,00n])",result,c(as.POSIXct("1970-01-01 13:30:10.008007006",tz="UTC"),as.POSIXct(NA,tz="UTC")),mode="in")
    result <- dbRun(conn,"set(array(NANOTIME))")
    record <- assert(record,"download set nanotime empty",result,as.POSIXct(c(),tz="UTC"))

    # nanotimestamp
    result <- dbRun(conn,"set([2012.06.13T13:30:10.008007006N,00N])")
    record <- assert(record,"download set nanotimestamp set([2012.06.13T13:30:10.008007006N,00N])",result,c(as.POSIXct("2012-06-13 13:30:10.008007006",tz="UTC"),as.POSIXct(NA,tz="UTC")),mode="in")
    result <- dbRun(conn,"set(array(NANOTIMESTAMP))")
    record <- assert(record,"download set nanotimestamp empty",result,as.POSIXct(c(),tz="UTC"))

    # float
    result <- dbRun(conn,"set([0.0f,float('nan'),float('inf'),00f])")
    record <- assert(record,"download set float set([0.0f,float('nan'),float('inf'),00f])",result,c(0,NaN,Inf,NA_real_),mode="in")
    result <- dbRun(conn,"set(array(FLOAT))")
    record <- assert(record,"download set float empty",result,numeric(0))

    # double
    result <- dbRun(conn,"set([0.0F,00F])")
    record <- assert(record,"download set double set([0.0F,00F])",result,c(0,NA_real_),mode="in")
    result <- dbRun(conn,"set(array(DOUBLE))")
    record <- assert(record,"download set double empty",result,numeric(0))

    # string
    result <- dbRun(conn,"set([`a,\"\"])")
    record <- assert(record,"download set string set([`a,\"\"])",result,c("a",NA_character_),mode="in")
    result <- dbRun(conn,"set(array(STRING))")
    record <- assert(record,"download set string empty",result,character(0))

    printTestResult(record)
    conn <- dbClose(conn)
} else {
    stop("connect error in TestDownloadSet.R")
}