source("setup/Settings.R")
source("pub/Assert.R")

library(RDolphinDB)

conn <- dbConnect(DolphinDB(),HOST,PORT,USER,PASSWD)
if (conn@connected){
    record <- c(0L,0L)
    # void
    result <- dbRun(conn,"NULL")
    record <- assert(record,"download scalar void",result,NA)

    # bool
    result <- dbRun(conn,"true")
    record <- assert(record,"download scalar bool true",result,TRUE)
    result <- dbRun(conn,"false")
    record <- assert(record,"download scalar bool true",result,FALSE)
    result <- dbRun(conn,"00b")
    record <- assert(record,"download scalar bool true",result,NA)

    # char
    result <- dbRun(conn,"0c")
    record <- assert(record,"download scalar char 0c",result,0L)
    result <- dbRun(conn,"127c")
    record <- assert(record,"download scalar char 128c",result,127L)
    result <- dbRun(conn,"-127c")
    record <- assert(record,"download scalar char -127c",result,-127L)
    result <- dbRun(conn,"00c")
    record <- assert(record,"download scalar char 00c",result,NA_integer_)

    # short
    result <- dbRun(conn,"0h")
    record <- assert(record,"download scalar short 0h",result,0L)
    result <- dbRun(conn,"32767h")
    record <- assert(record,"download scalar short 32767h",result,32767L)
    result <- dbRun(conn,"-32767h")
    record <- assert(record,"download scalar short -32767h",result,-32767L)
    result <- dbRun(conn,"00h")
    record <- assert(record,"download scalar short 00h",result,NA_integer_)

    # int
    result <- dbRun(conn,"0i")
    record <- assert(record,"download scalar int 0i",result,0L)
    result <- dbRun(conn,"2147483647i")
    record <- assert(record,"download scalar int 2147483647i",result,2147483647L)
    result <- dbRun(conn,"-2147483647i")
    record <- assert(record,"download scalar int -2147483647i",result,-2147483647L)
    result <- dbRun(conn,"00i")
    record <- assert(record,"download scalar int 00i",result,NA_integer_)

    # long
    result <- dbRun(conn,"0l")
    record <- assert(record,"download scalar long 0l",result,0)
    result <- dbRun(conn,"9223372036854775807l")
    record <- assert(record,"download scalar long 9223372036854775807l",result,9223372036854775807)
    result <- dbRun(conn,"-9223372036854775807l")
    record <- assert(record,"download scalar long -9223372036854775807l",result,-9223372036854775807)
    result <- dbRun(conn,"00l")
    record <- assert(record,"download scalar long 00l",result,NA_real_)

    # date
    result <- dbRun(conn,"1970.01.01d")
    record <- assert(record,"download scalar date 1970.01.01d",result,as.Date("1970-01-01"))
    result <- dbRun(conn,"00d")
    record <- assert(record,"download scalar date 00d",result,as.Date(NA))

    # month
    result <- dbRun(conn,"1970.01M")
    record <- assert(record,"download scalar month 1970.01M",result,as.Date("1970-01-01"))
    result <- dbRun(conn,"00M")
    record <- assert(record,"download scalar month 00m",result,as.Date(NA))

    # time
    result <- dbRun(conn,"13:30:10.008t")
    record <- assert(record,"download scalar time 13:30:10.008t",result,as.POSIXct("1970-01-01 13:30:10.008",tz="UTC"))
    result <- dbRun(conn,"00t")
    record <- assert(record,"download scalar time 00t",result,as.POSIXct(NA))

    # minute
    result <- dbRun(conn,"13:30m")
    record <- assert(record,"download scalar minute 13:30m",result,as.POSIXct("1970-01-01 13:30:00",tz="UTC"))
    result <- dbRun(conn,"00m")
    record <- assert(record,"download scalar minute 00m",result,as.POSIXct(NA))

    # second
    result <- dbRun(conn,"13:30:10s")
    record <- assert(record,"download scalar second 13:30:10s",result,as.POSIXct("1970-01-01 13:30:10",tz="UTC"))
    result <- dbRun(conn,"00s")
    record <- assert(record,"download scalar second 00s",result,as.POSIXct(NA))

    # datetime
    result <- dbRun(conn,"2012.06.13T13:30:10D")
    record <- assert(record,"download scalar datetime 2012.06.13T13:30:10D",result,as.POSIXct("2012-06-13 13:30:10",tz="UTC"))
    result <- dbRun(conn,"00D")
    record <- assert(record,"download scalar datetime 00D",result,as.POSIXct(NA))

    # timestamp
    result <- dbRun(conn,"2012.06.13T13:30:10.008T")
    record <- assert(record,"download scalar timestamp 2012.06.13T13:30:10.008T",result,as.POSIXct("2012-06-13 13:30:10.008",tz="UTC"))
    result <- dbRun(conn,"00T")
    record <- assert(record,"download scalar timestamp 00T",result,as.POSIXct(NA))

    # nanotime
    result <- dbRun(conn,"13:30:10.008007006n")
    record <- assert(record,"download scalar nanotime 13:30:10.008007006n",result,as.POSIXct("1970-01-01 13:30:10.008007006",tz="UTC"))
    result <- dbRun(conn,"00n")
    record <- assert(record,"download scalar nanotime 00n",result,as.POSIXct(NA))

    # nanotimestamp
    result <- dbRun(conn,"2012.06.13T13:30:10.008007006N")
    record <- assert(record,"download scalar nanotimestamp 2012.06.13T13:30:10.008007006N",result,as.POSIXct("2012-06-13 13:30:10.008007006",tz="UTC"))
    result <- dbRun(conn,"00N")
    record <- assert(record,"download scalar nanotimestamp 00N",result,as.POSIXct(NA))

    # float
    result <- dbRun(conn,"0.0f")
    record <- assert(record,"download scalar float 0.0f",result,0)
    result <- dbRun(conn,"float('nan')")
    record <- assert(record,"download scalar float nan",result,NaN)
    result <- dbRun(conn,"float('inf')")
    record <- assert(record,"download scalar float inf",result,Inf)
    result <- dbRun(conn,"00f")
    record <- assert(record,"download scalar float 00f",result,NA_real_)

    # double
    result <- dbRun(conn,"0.0F")
    record <- assert(record,"download scalar double 0.0f",result,0)
    result <- dbRun(conn,"pi")
    record <- assert(record,"download scalar double 0.0f",result,pi)
    result <- dbRun(conn,"00F")
    record <- assert(record,"download scalar double 00F",result,NA_real_)

    # string
    result <- dbRun(conn,"'abc!@#中文 123'")
    record <- assert(record,"download scalar string 'abc!@#中文 123'",result,"abc!@#中文 123")
    result <- dbRun(conn,"\"\"")
    record <- assert(record,"download scalar string \"\"",result,NA_character_)

    printTestResult(record)
    conn <- dbClose(conn)
} else {
    stop("connect error in TestDownloadScalar.R")
}