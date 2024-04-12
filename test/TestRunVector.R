source("setup/Settings.R")
source("pub/Assert.R")

library(RDolphinDB)

conn <- dbConnect(DolphinDB(),HOST,PORT,USER,PASSWD)
if (conn@connected){
    record <- c(0L,0L)
    # bool
    result <- dbRun(conn,"[true,false,00b]")
    record <- assert(record,"download vector bool [true,false,00b]",result,c(TRUE,FALSE,NA))
    result <- dbRun(conn,"array(BOOL)")
    record <- assert(record,"download vector bool empty",result,logical(0))

    # char
    result <- dbRun(conn,"[0c,127c,00c]")
    record <- assert(record,"download vector char [0c,127c,00c]",result,c(0L,127L,NA_integer_))
    result <- dbRun(conn,"array(CHAR)")
    record <- assert(record,"download vector char empty",result,integer(0))

    # short
    result <- dbRun(conn,"[0h,32767h,00h]")
    record <- assert(record,"download vector short [0h,32767h,00h]",result,c(0L,32767L,NA_integer_))
    result <- dbRun(conn,"array(SHORT)")
    record <- assert(record,"download vector short empty",result,integer(0))

    # int
    result <- dbRun(conn,"[0i,2147483647i,00i]")
    record <- assert(record,"download vector int [0i,2147483647i,00i]",result,c(0L,2147483647L,NA_integer_))
    result <- dbRun(conn,"array(INT)")
    record <- assert(record,"download vector short empty",result,integer(0))

    # long
    result <- dbRun(conn,"[0l,9223372036854775807l,00l]")
    record <- assert(record,"download vector long [0l,9223372036854775807l,00l]",result,c(0,9223372036854775807,NA_real_))
    result <- dbRun(conn,"array(LONG)")
    record <- assert(record,"download vector long empty",result,numeric(0))

    # date
    result <- dbRun(conn,"[1970.01.01d,00d]")
    record <- assert(record,"download vector date [1970.01.01d,00d]",result,c(as.Date("1970-01-01"),NA))
    result <- dbRun(conn,"array(DATE)")
    record <- assert(record,"download vector date empty",result,as.Date(c()))

    # month
    result <- dbRun(conn,"[1970.01M,00M]")
    record <- assert(record,"download vector month [1970.01M,00M]",result,c(as.Date("1970-01-01"),NA))
    result <- dbRun(conn,"array(MONTH)")
    record <- assert(record,"download vector month empty",result,as.Date(c()))

    # time
    result <- dbRun(conn,"[13:30:10.008t,00t]")
    record <- assert(record,"download vector time [13:30:10.008t,00t]",result,c(as.POSIXct("1970-01-01 13:30:10.008",tz="UTC"),as.POSIXct(NA,tz="UTC")))
    result <- dbRun(conn,"array(TIME)")
    record <- assert(record,"download vector time empty",result,as.POSIXct(c(),tz="UTC"))

    # minute
    result <- dbRun(conn,"[13:30m,00m]")
    record <- assert(record,"download vector minute [13:30m,00m]",result,c(as.POSIXct("1970-01-01 13:30:00",tz="UTC"),as.POSIXct(NA,tz="UTC")))
    result <- dbRun(conn,"array(MINUTE)")
    record <- assert(record,"download vector minute empty",result,as.POSIXct(c(),tz="UTC"))

    # second
    result <- dbRun(conn,"[13:30:10s,00s]")
    record <- assert(record,"download vector second [13:30:10s,00s]",result,c(as.POSIXct("1970-01-01 13:30:10",tz="UTC"),as.POSIXct(NA,tz="UTC")))
    result <- dbRun(conn,"array(SECOND)")
    record <- assert(record,"download vector second empty",result,as.POSIXct(c(),tz="UTC"))

    # datetime
    result <- dbRun(conn,"[2012.06.13T13:30:10D,00D]")
    record <- assert(record,"download vector datetime [2012.06.13T13:30:10D,00D]",result,c(as.POSIXct("2012-06-13 13:30:10",tz="UTC"),as.POSIXct(NA,tz="UTC")))
    result <- dbRun(conn,"array(DATETIME)")
    record <- assert(record,"download vector datetime empty",result,as.POSIXct(c(),tz="UTC"))

    # timestamp
    result <- dbRun(conn,"[2012.06.13T13:30:10.008T,00T]")
    record <- assert(record,"download vector timestamp [2012.06.13T13:30:10.008T,00T]",result,c(as.POSIXct("2012-06-13 13:30:10.008",tz="UTC"),as.POSIXct(NA,tz="UTC")))
    result <- dbRun(conn,"array(TIMESTAMP)")
    record <- assert(record,"download vector timestamp empty",result,as.POSIXct(c(),tz="UTC"))

    # nanotime
    result <- dbRun(conn,"[13:30:10.008007006n,00n]")
    record <- assert(record,"download vector nanotime [13:30:10.008007006n,00n]",result,c(as.POSIXct("1970-01-01 13:30:10.008007006",tz="UTC"),as.POSIXct(NA,tz="UTC")))
    result <- dbRun(conn,"array(NANOTIME)")
    record <- assert(record,"download vector nanotime empty",result,as.POSIXct(c(),tz="UTC"))

    # nanotimestamp
    result <- dbRun(conn,"[2012.06.13T13:30:10.008007006N,00N]")
    record <- assert(record,"download vector nanotimestamp [2012.06.13T13:30:10.008007006N,00N]",result,c(as.POSIXct("2012-06-13 13:30:10.008007006",tz="UTC"),as.POSIXct(NA,tz="UTC")))
    result <- dbRun(conn,"array(NANOTIMESTAMP)")
    record <- assert(record,"download vector nanotimestamp empty",result,as.POSIXct(c(),tz="UTC"))

    # float
    result <- dbRun(conn,"[0.0f,float('nan'),float('inf'),00f]")
    record <- assert(record,"download vector float [0.0f,float('nan'),float('inf'),00f]",result,c(0,NaN,Inf,NA_real_))
    result <- dbRun(conn,"array(FLOAT)")
    record <- assert(record,"download vector float empty",result,numeric(0))

    # double
    result <- dbRun(conn,"[0.0F,00F]")
    record <- assert(record,"download vector double [0.0F,00F]",result,c(0,NA_real_))
    result <- dbRun(conn,"array(DOUBLE)")
    record <- assert(record,"download vector double empty",result,numeric(0))

    # string
    result <- dbRun(conn,"[`a,\"\"]")
    record <- assert(record,"download vector string [`a,\"\"]",result,c("a",NA_character_))
    result <- dbRun(conn,"array(STRING)")
    record <- assert(record,"download vector string empty",result,character(0))

    # symbol not support
    # result <- dbRun(conn,"symbol([`a,\"\"])")
    # record <- assert(record,"download vector symbol 1",result,c("a",""))

    # any empty
    result <- dbRun(conn,"array(ANY)")
    record <- assert(record,"download vector empty 1",result,list())

    # any vector
    result <- dbRun(conn,"x=array(ANY).append!(true).append!(0c).append!(0h).append!(0i);x")
    record <- assert(record,"download vector any",result,list(TRUE,0L,0L,0L))

    printTestResult(record)
    conn <- dbClose(conn)
} else {
    stop("connect error in TestDownloadVector.R")
}