source("setup/Settings.R")
source("pub/Assert.R")

library(RDolphinDB)

conn <- dbConnect(DolphinDB(),HOST,PORT,USER,PASSWD)
if (conn@connected){
    record <- c(0L,0L)
    # bool
    result <- dbRun(conn,"true:false")
    record <- assert(record,"download pair bool 1",result,c(TRUE,FALSE))
    result <- dbRun(conn,"true:00b")
    record <- assert(record,"download pair bool 2",result,c(TRUE,NA))

    # char
    result <- dbRun(conn,"0c:127c")
    record <- assert(record,"download pair char 1",result,c(0L,127L))
    result <- dbRun(conn,"0c:00c")
    record <- assert(record,"download pair char 2",result,c(0L,NA))

    # short
    result <- dbRun(conn,"0h:32767h")
    record <- assert(record,"download pair short 1",result,c(0L,32767L))
    result <- dbRun(conn,"0h:00h")
    record <- assert(record,"download pair short 2",result,c(0L,NA))

    # int
    result <- dbRun(conn,"0i:2147483647i")
    record <- assert(record,"download pair int 1",result,c(0L,2147483647L))
    result <- dbRun(conn,"0i:00i")
    record <- assert(record,"download pair int 2",result,c(0L,NA))

    # long
    result <- dbRun(conn,"0l:9223372036854775807l")
    record <- assert(record,"download pair long 1",result,c(0L,9223372036854775807))
    result <- dbRun(conn,"0l:00l")
    record <- assert(record,"download pair long 2",result,c(0,NA))

    # date
    result <- dbRun(conn,"1970.01.01d:1970.01.02d")
    record <- assert(record,"download pair date 1",result,c(as.Date("1970-01-01"),as.Date("1970-01-02")))
    result <- dbRun(conn,"1970.01.01d:00d")
    record <- assert(record,"download pair date 2",result,c(as.Date("1970-01-01"),NA))

    # month
    result <- dbRun(conn,"1970.01M:1970.02M")
    record <- assert(record,"download pair month 1",result,c(as.Date("1970-01-01"),as.Date("1970-02-01")))
    result <- dbRun(conn,"1970.01M:00M")
    record <- assert(record,"download pair month 2",result,c(as.Date("1970-01-01"),NA))

    # second
    result <- dbRun(conn,"13:30:10s:13:30:11s")
    record <- assert(record,"download pair second 1",result,c(as.POSIXct("1970-01-01 13:30:10",tz="UTC"),as.POSIXct("1970-01-01 13:30:11",tz="UTC")))
    result <- dbRun(conn,"13:30:10s : 00s")
    record <- assert(record,"download pair second 2",result,c(as.POSIXct("1970-01-01 13:30:10",tz="UTC"),as.POSIXct(NA,tz="UTC")))

    # datetime
    result <- dbRun(conn,"2012.06.13T13:30:10D : 2012.06.13T13:30:11D")
    record <- assert(record,"download pair datetime 1",result,c(as.POSIXct("2012-06-13 13:30:10",tz="UTC"),as.POSIXct("2012-06-13 13:30:11",tz="UTC")))
    result <- dbRun(conn,"2012.06.13T13:30:10D : 00D")
    record <- assert(record,"download pair datetime 2",result,c(as.POSIXct("2012-06-13 13:30:10",tz="UTC"),as.POSIXct(NA,tz="UTC")))

    # timestamp
    result <- dbRun(conn,"2012.06.13T13:30:10.008T : 2012.06.13T13:30:10.009T")
    record <- assert(record,"download pair timestamp 1",result,c(as.POSIXct("2012-06-13 13:30:10.008",tz="UTC"),as.POSIXct("2012-06-13 13:30:10.009",tz="UTC")))
    result <- dbRun(conn,"2012.06.13T13:30:10.008T : 00T")
    record <- assert(record,"download pair timestamp 2",result,c(as.POSIXct("2012-06-13 13:30:10.008",tz="UTC"),as.POSIXct(NA,tz="UTC")))

    # nanotime
    result <- dbRun(conn,"13:30:10.008007006n : 13:30:10.008007007n")
    record <- assert(record,"download pair nanotime 1",result,c(as.POSIXct("1970-01-01 13:30:10.008007006",tz="UTC"),as.POSIXct("1970-01-01 13:30:10.008007007",tz="UTC")))
    result <- dbRun(conn,"13:30:10.008007006n : 00n")
    record <- assert(record,"download pair nanotime 2",result,c(as.POSIXct("1970-01-01 13:30:10.008007006",tz="UTC"),as.POSIXct(NA,tz="UTC")))

    # nanotimestamp
    result <- dbRun(conn,"2012.06.13T13:30:10.008007006N : 2012.06.13T13:30:10.008007007N")
    record <- assert(record,"download pair nanotimestamp 1",result,c(as.POSIXct("2012-06-13 13:30:10.008007006",tz="UTC"),as.POSIXct("2012-06-13 13:30:10.008007007",tz="UTC")))
    result <- dbRun(conn,"2012.06.13T13:30:10.008007006N : 00N")
    record <- assert(record,"download pair nanotimestamp 2",result,c(as.POSIXct("2012-06-13 13:30:10.008007006",tz="UTC"),as.POSIXct(NA,tz="UTC")))

    # float
    result <- dbRun(conn,"0.0f:0.1f")
    record <- assert(record,"download pair float 1",result,c(0,0.1))
    result <- dbRun(conn,"0.0f:float('nan')")
    record <- assert(record,"download pair float 2",result,c(0,NaN))
    result <- dbRun(conn,"0.0f:float('inf')")
    record <- assert(record,"download pair float 3",result,c(0,Inf))
    result <- dbRun(conn,"0.0f:00f")
    record <- assert(record,"download pair float 4",result,c(0,NA))

    # double
    result <- dbRun(conn,"0.0F:0.1F")
    record <- assert(record,"download pair double 1",result,c(0,0.1))
    result <- dbRun(conn,"0.0F:00F")
    record <- assert(record,"download pair double 2",result,c(0,NA))

    # string
    result <- dbRun(conn,"`a:`b")
    record <- assert(record,"download pair string 1",result,c("a","b"))
    result <- dbRun(conn,"`a:\"\"")
    record <- assert(record,"download pair string 2",result,c("a",NA))

    printTestResult(record)
    conn <- dbClose(conn)
} else {
    stop("connect error in TestDownloadPair.R")
}