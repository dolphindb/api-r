source("setup/Settings.R")
source("pub/Assert.R")

library(RDolphinDB)

conn <- dbConnect(DolphinDB(),HOST,PORT,USER,PASSWD)
if (conn@connected){
    record <- c(0L,0L)
    # bool
    result <- dbRun(conn,"table([true,false,00b] as `a)")
    expect <- data.frame(
        a = c(TRUE,FALSE,NA)
    )
    record <- assert(record,"download table bool 1",result,expect)

    # char
    result <- dbRun(conn,"table([0c,127c,00c] as `a)")
    expect <- data.frame(
        a = c(0L,127L,NA)
    )
    record <- assert(record,"download table char 1",result,expect)

    # short
    result <- dbRun(conn,"table([0h,32767h,00h] as `a)")
    expect <- data.frame(
        a = c(0L,32767L,NA)
    )
    record <- assert(record,"download table short 1",result,expect)

    # int
    result <- dbRun(conn,"table([0i,2147483647i,00i] as `a)")
    expect <- data.frame(
        a = c(0L,2147483647L,NA)
    )
    record <- assert(record,"download table int 1",result,expect)

    # long
    result <- dbRun(conn,"table([0l,9223372036854775807l,00l] as `a)")
    expect <- data.frame(
        a = c(0,9223372036854775807,NA)
    )
    record <- assert(record,"download table long 1",result,expect)

    # date
    result <- dbRun(conn,"table([1970.01.01d,00d] as `a)")
    expect <- data.frame(
        a = c(as.Date("1970-01-01"),NA)
    )
    record <- assert(record,"download table date 1",result,expect)

    # month
    result <- dbRun(conn,"table([1970.01M,00M] as `a)")
    expect <- data.frame(
        a = c(as.Date("1970-01-01"),NA)
    )
    record <- assert(record,"download table month 1",result,expect)

    # time
    result <- dbRun(conn,"table([13:30:10.008t,00t] as `a)")
    expect <- data.frame(
        a = c(as.POSIXct("1970-01-01 13:30:10.008",tz="UTC"),as.POSIXct(NA,tz="UTC"))
    )
    record <- assert(record,"download table time 1",result,expect)

    # minute
    result <- dbRun(conn,"table([13:30m,00m] as `a)")
    expect <- data.frame(
        a = c(as.POSIXct("1970-01-01 13:30:00",tz="UTC"),as.POSIXct(NA,tz="UTC"))
    )
    record <- assert(record,"download table minute 1",result,expect)

    # second
    result <- dbRun(conn,"table([13:30:10s,00s] as `a)")
    expect <- data.frame(
        a = c(as.POSIXct("1970-01-01 13:30:10",tz="UTC"),as.POSIXct(NA,tz="UTC"))
    )
    record <- assert(record,"download table second 1",result,expect)

    # datetime
    result <- dbRun(conn,"table([2012.06.13T13:30:10D,00D] as `a)")
    expect <- data.frame(
        a = c(as.POSIXct("2012-06-13 13:30:10",tz="UTC"),as.POSIXct(NA,tz="UTC"))
    )
    record <- assert(record,"download table datetime 1",result,expect)

    # timestamp
    result <- dbRun(conn,"table([2012.06.13T13:30:10.008T,00T] as `a)")
    expect <- data.frame(
        a = c(as.POSIXct("2012-06-13 13:30:10.008",tz="UTC"),as.POSIXct(NA,tz="UTC"))
    )
    record <- assert(record,"download table timestamp 1",result,expect)

    # nanotime
    result <- dbRun(conn,"table([13:30:10.008007006n,00n] as `a)")
    expect <- data.frame(
        a = c(as.POSIXct("1970-01-01 13:30:10.008007006",tz="UTC"),as.POSIXct(NA,tz="UTC"))
    )
    record <- assert(record,"download table nanotime 1",result,expect)

    # nanotimestamp
    result <- dbRun(conn,"table([2012.06.13T13:30:10.008007006N,00N] as `a)")
    expect <- data.frame(
        a = c(as.POSIXct("2012-06-13 13:30:10.008007006",tz="UTC"),as.POSIXct(NA,tz="UTC"))
    )
    record <- assert(record,"download table nanotimestamp 1",result,expect)

    # float
    result <- dbRun(conn,"table([0.0f,float('nan'),float('inf'),00f] as `a)")
    expect <- data.frame(
        a = c(0,NaN,Inf,NA)
    )
    record <- assert(record,"download table float 1",result,expect)

    # double
    result <- dbRun(conn,"table([0.0F,00F] as `a)")
    expect <- data.frame(
        a = c(0,NA)
    )
    record <- assert(record,"download table double 1",result,expect)

    # string
    result <- dbRun(conn,"table([`a,\"\"] as `a)")
    expect <- data.frame(
        a = c("a","")
    )
    record <- assert(record,"download table string 1",result,expect)

    # empty
    result <- dbRun(conn,"table(100:0,[`a],[INT])")
    expect <- data.frame(
        a = as.integer(c())
    )
    record <- assert(record,"download table empty 1",result,expect)

    printTestResult(record)
    conn <- dbClose(conn)
} else {
    stop("connect error in TestDownloadTable.R")
}