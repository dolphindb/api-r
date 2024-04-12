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
    record <- assert(record,"download table bool table([true,false,00b] as `a)",result,expect)
    result <- dbRun(conn,"table(100:0,[`a],[BOOL])")
    expect <- data.frame(
        a = logical(0)
    )
    record <- assert(record,"download table bool empty",result,expect)

    # char
    result <- dbRun(conn,"table([0c,127c,00c] as `a)")
    expect <- data.frame(
        a = c(0L,127L,NA_integer_)
    )
    record <- assert(record,"download table char table([0c,127c,00c] as `a)",result,expect)
    result <- dbRun(conn,"table(100:0,[`a],[CHAR])")
    expect <- data.frame(
        a = integer(0)
    )
    record <- assert(record,"download table char empty",result,expect)

    # short
    result <- dbRun(conn,"table([0h,32767h,00h] as `a)")
    expect <- data.frame(
        a = c(0L,32767L,NA_integer_)
    )
    record <- assert(record,"download table short table([0h,32767h,00h] as `a)",result,expect)
    result <- dbRun(conn,"table(100:0,[`a],[SHORT])")
    expect <- data.frame(
        a = integer(0)
    )
    record <- assert(record,"download table short empty",result,expect)

    # int
    result <- dbRun(conn,"table([0i,2147483647i,00i] as `a)")
    expect <- data.frame(
        a = c(0L,2147483647L,NA_integer_)
    )
    record <- assert(record,"download table int table([0i,2147483647i,00i] as `a)",result,expect)
    result <- dbRun(conn,"table(100:0,[`a],[INT])")
    expect <- data.frame(
        a = integer(0)
    )
    record <- assert(record,"download table int empty",result,expect)

    # long
    result <- dbRun(conn,"table([0l,9223372036854775807l,00l] as `a)")
    expect <- data.frame(
        a = c(0,9223372036854775807,NA_real_)
    )
    record <- assert(record,"download table long table([0l,9223372036854775807l,00l] as `a)",result,expect)
    result <- dbRun(conn,"table(100:0,[`a],[LONG])")
    expect <- data.frame(
        a = numeric(0)
    )
    record <- assert(record,"download table long empty",result,expect)

    # date
    result <- dbRun(conn,"table([1970.01.01d,00d] as `a)")
    expect <- data.frame(
        a = c(as.Date("1970-01-01"),NA)
    )
    record <- assert(record,"download table date table([1970.01.01d,00d] as `a)",result,expect)
    result <- dbRun(conn,"table(100:0,[`a],[DATE])")
    expect <- data.frame(
        a = as.Date(c())
    )
    record <- assert(record,"download table date empty",result,expect)

    # month
    result <- dbRun(conn,"table([1970.01M,00M] as `a)")
    expect <- data.frame(
        a = c(as.Date("1970-01-01"),NA)
    )
    record <- assert(record,"download table month table([1970.01M,00M] as `a)",result,expect)
    # result <- dbRun(conn,"table(100:0,[`a],[MONTH])")
    # expect <- data.frame(
    #     a = as.Date(c())
    # )
    # record <- assert(record,"download table month empty",result,expect)

    # time
    result <- dbRun(conn,"table([13:30:10.008t,00t] as `a)")
    expect <- data.frame(
        a = c(as.POSIXct("1970-01-01 13:30:10.008",tz="UTC"),as.POSIXct(NA,tz="UTC"))
    )
    record <- assert(record,"download table time table([13:30:10.008t,00t] as `a)",result,expect)
    result <- dbRun(conn,"table(100:0,[`a],[TIME])")
    expect <- data.frame(
        a = as.POSIXct(c(),tz="UTC")
    )
    record <- assert(record,"download table time empty",result,expect)

    # minute
    result <- dbRun(conn,"table([13:30m,00m] as `a)")
    expect <- data.frame(
        a = c(as.POSIXct("1970-01-01 13:30:00",tz="UTC"),as.POSIXct(NA,tz="UTC"))
    )
    record <- assert(record,"download table minute table([13:30m,00m] as `a)",result,expect)
    result <- dbRun(conn,"table(100:0,[`a],[MINUTE])")
    expect <- data.frame(
        a = as.POSIXct(c(),tz="UTC")
    )
    record <- assert(record,"download table minute empty",result,expect)

    # second
    result <- dbRun(conn,"table([13:30:10s,00s] as `a)")
    expect <- data.frame(
        a = c(as.POSIXct("1970-01-01 13:30:10",tz="UTC"),as.POSIXct(NA,tz="UTC"))
    )
    record <- assert(record,"download table second table([13:30:10s,00s] as `a)",result,expect)
    result <- dbRun(conn,"table(100:0,[`a],[SECOND])")
    expect <- data.frame(
        a = as.POSIXct(c(),tz="UTC")
    )
    record <- assert(record,"download table second empty",result,expect)

    # datetime
    result <- dbRun(conn,"table([2012.06.13T13:30:10D,00D] as `a)")
    expect <- data.frame(
        a = c(as.POSIXct("2012-06-13 13:30:10",tz="UTC"),as.POSIXct(NA,tz="UTC"))
    )
    record <- assert(record,"download table datetime table([2012.06.13T13:30:10D,00D] as `a)",result,expect)
    result <- dbRun(conn,"table(100:0,[`a],[DATETIME])")
    expect <- data.frame(
        a = as.POSIXct(c(),tz="UTC")
    )
    record <- assert(record,"download table datetime empty",result,expect)

    # timestamp
    result <- dbRun(conn,"table([2012.06.13T13:30:10.008T,00T] as `a)")
    expect <- data.frame(
        a = c(as.POSIXct("2012-06-13 13:30:10.008",tz="UTC"),as.POSIXct(NA,tz="UTC"))
    )
    record <- assert(record,"download table timestamp table([2012.06.13T13:30:10.008T,00T] as `a)",result,expect)
    result <- dbRun(conn,"table(100:0,[`a],[TIMESTAMP])")
    expect <- data.frame(
        a = as.POSIXct(c(),tz="UTC")
    )
    record <- assert(record,"download table timestamp empty",result,expect)

    # nanotime
    result <- dbRun(conn,"table([13:30:10.008007006n,00n] as `a)")
    expect <- data.frame(
        a = c(as.POSIXct("1970-01-01 13:30:10.008007006",tz="UTC"),as.POSIXct(NA,tz="UTC"))
    )
    record <- assert(record,"download table nanotime table([13:30:10.008007006n,00n] as `a)",result,expect)
    result <- dbRun(conn,"table(100:0,[`a],[NANOTIME])")
    expect <- data.frame(
        a = as.POSIXct(c(),tz="UTC")
    )
    record <- assert(record,"download table nanotime empty",result,expect)

    # nanotimestamp
    result <- dbRun(conn,"table([2012.06.13T13:30:10.008007006N,00N] as `a)")
    expect <- data.frame(
        a = c(as.POSIXct("2012-06-13 13:30:10.008007006",tz="UTC"),as.POSIXct(NA,tz="UTC"))
    )
    record <- assert(record,"download table nanotimestamp table([2012.06.13T13:30:10.008007006N,00N] as `a)",result,expect)
    result <- dbRun(conn,"table(100:0,[`a],[NANOTIMESTAMP])")
    expect <- data.frame(
        a = as.POSIXct(c(),tz="UTC")
    )
    record <- assert(record,"download table nanotimestamp empty",result,expect)

    # float
    result <- dbRun(conn,"table([0.0f,float('nan'),float('inf'),00f] as `a)")
    expect <- data.frame(
        a = c(0,NaN,Inf,NA_real_)
    )
    record <- assert(record,"download table float table([0.0f,float('nan'),float('inf'),00f] as `a)",result,expect)
    result <- dbRun(conn,"table(100:0,[`a],[FLOAT])")
    expect <- data.frame(
        a = numeric(0)
    )
    record <- assert(record,"download table float empty",result,expect)

    # double
    result <- dbRun(conn,"table([0.0F,00F] as `a)")
    expect <- data.frame(
        a = c(0,NA_real_)
    )
    record <- assert(record,"download table double table([0.0F,00F] as `a)",result,expect)
    result <- dbRun(conn,"table(100:0,[`a],[DOUBLE])")
    expect <- data.frame(
        a = numeric(0)
    )
    record <- assert(record,"download table double empty",result,expect)

    # string
    result <- dbRun(conn,"table([`a,\"\"] as `a)")
    expect <- data.frame(
        a = c("a",NA_character_)
    )
    record <- assert(record,"download table string table([`a,\"\"] as `a)",result,expect)
    result <- dbRun(conn,"table(100:0,[`a],[STRING])")
    expect <- data.frame(
        a = character(0)
    )
    record <- assert(record,"download table string empty",result,expect)

    printTestResult(record)
    conn <- dbClose(conn)
} else {
    stop("connect error in TestDownloadTable.R")
}