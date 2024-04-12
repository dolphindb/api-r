source("setup/Settings.R")
source("pub/Assert.R")

library(RDolphinDB)

conn <- dbConnect(DolphinDB(),HOST,PORT,USER,PASSWD)
if (conn@connected){
    record <- c(0L,0L)
    # bool
    result <- dbRun(conn,"true:false")
    record <- assert(record,"download pair bool true:false",result,c(TRUE,FALSE))
    result <- dbRun(conn,"true:00b")
    record <- assert(record,"download pair bool true:00b",result,c(TRUE,NA))

    # char
    result <- dbRun(conn,"0c:127c")
    record <- assert(record,"download pair char 0c:127c",result,c(0L,127L))
    result <- dbRun(conn,"0c:00c")
    record <- assert(record,"download pair char 0c:00c",result,c(0L,NA_integer_))

    # short
    result <- dbRun(conn,"0h:32767h")
    record <- assert(record,"download pair short 0h:32767h",result,c(0L,32767L))
    result <- dbRun(conn,"0h:00h")
    record <- assert(record,"download pair short 0h:00h",result,c(0L,NA_integer_))

    # int
    result <- dbRun(conn,"0i:2147483647i")
    record <- assert(record,"download pair int 0i:2147483647i1",result,c(0L,2147483647L))
    result <- dbRun(conn,"0i:00i")
    record <- assert(record,"download pair int 0i:00i",result,c(0L,NA_integer_))

    # long
    result <- dbRun(conn,"0l:9223372036854775807l")
    record <- assert(record,"download pair long 0l:9223372036854775807l",result,c(0L,9223372036854775807))
    result <- dbRun(conn,"0l:00l")
    record <- assert(record,"download pair long 0l:00l",result,c(0,NA_real_))

    # date
    result <- dbRun(conn,"1970.01.01d:1970.01.02d")
    record <- assert(record,"download pair date 1970.01.01d:1970.01.02d",result,c(as.Date("1970-01-01"),as.Date("1970-01-02")))
    result <- dbRun(conn,"1970.01.01d:00d")
    record <- assert(record,"download pair date 1970.01.01d:00d",result,c(as.Date("1970-01-01"),NA))

    # month
    result <- dbRun(conn,"1970.01M:1970.02M")
    record <- assert(record,"download pair month 1970.01M:1970.02M",result,c(as.Date("1970-01-01"),as.Date("1970-02-01")))
    result <- dbRun(conn,"1970.01M:00M")
    record <- assert(record,"download pair month 1970.01M:00M",result,c(as.Date("1970-01-01"),NA))

    # time
    result <- dbRun(conn,"13:30:10.008t : 13:30:10.008t")
    record <- assert(record,"download pair time 13:30:10.008t : 13:30:10.008t",result,c(as.POSIXct("1970-01-01 13:30:10.008",tz="UTC"),as.POSIXct("1970-01-01 13:30:10.008",tz="UTC")))
    result <- dbRun(conn,"1970.01M:00M")
    record <- assert(record,"download pair time 1970.01M:00M",result,c(as.Date("1970-01-01"),NA))

    # minute
    result <- dbRun(conn,"13:30m : 13:30m")
    record <- assert(record,"download pair minute 13:30m : 13:30m",result,c(as.POSIXct("1970-01-01 13:30:00",tz="UTC"),as.POSIXct("1970-01-01 13:30:00",tz="UTC")))
    result <- dbRun(conn,"1970.01M:00M")
    record <- assert(record,"download pair minute 1970.01M:00M",result,c(as.Date("1970-01-01"),NA))

    # second
    result <- dbRun(conn,"13:30:10s : 13:30:11s")
    record <- assert(record,"download pair second 13:30:10s : 13:30:11s",result,c(as.POSIXct("1970-01-01 13:30:10",tz="UTC"),as.POSIXct("1970-01-01 13:30:11",tz="UTC")))
    result <- dbRun(conn,"13:30:10s : 00s")
    record <- assert(record,"download pair second 13:30:10s : 00s",result,c(as.POSIXct("1970-01-01 13:30:10",tz="UTC"),as.POSIXct(NA,tz="UTC")))

    # datetime
    result <- dbRun(conn,"2012.06.13T13:30:10D : 2012.06.13T13:30:11D")
    record <- assert(record,"download pair datetime 2012.06.13T13:30:10D : 2012.06.13T13:30:11D",result,c(as.POSIXct("2012-06-13 13:30:10",tz="UTC"),as.POSIXct("2012-06-13 13:30:11",tz="UTC")))
    result <- dbRun(conn,"2012.06.13T13:30:10D : 00D")
    record <- assert(record,"download pair datetime 2012.06.13T13:30:10D : 00D",result,c(as.POSIXct("2012-06-13 13:30:10",tz="UTC"),as.POSIXct(NA,tz="UTC")))

    # timestamp
    result <- dbRun(conn,"2012.06.13T13:30:10.008T : 2012.06.13T13:30:10.009T")
    record <- assert(record,"download pair timestamp 2012.06.13T13:30:10.008T : 2012.06.13T13:30:10.009T",result,c(as.POSIXct("2012-06-13 13:30:10.008",tz="UTC"),as.POSIXct("2012-06-13 13:30:10.009",tz="UTC")))
    result <- dbRun(conn,"2012.06.13T13:30:10.008T : 00T")
    record <- assert(record,"download pair timestamp 2012.06.13T13:30:10.008T : 00T",result,c(as.POSIXct("2012-06-13 13:30:10.008",tz="UTC"),as.POSIXct(NA,tz="UTC")))

    # nanotime
    result <- dbRun(conn,"13:30:10.008007006n : 13:30:10.008007007n")
    record <- assert(record,"download pair nanotime 13:30:10.008007006n : 13:30:10.008007007n",result,c(as.POSIXct("1970-01-01 13:30:10.008007006",tz="UTC"),as.POSIXct("1970-01-01 13:30:10.008007007",tz="UTC")))
    result <- dbRun(conn,"13:30:10.008007006n : 00n")
    record <- assert(record,"download pair nanotime 13:30:10.008007006n : 00n",result,c(as.POSIXct("1970-01-01 13:30:10.008007006",tz="UTC"),as.POSIXct(NA,tz="UTC")))

    # nanotimestamp
    result <- dbRun(conn,"2012.06.13T13:30:10.008007006N : 2012.06.13T13:30:10.008007007N")
    record <- assert(record,"download pair nanotimestamp 2012.06.13T13:30:10.008007006N : 2012.06.13T13:30:10.008007007N",result,c(as.POSIXct("2012-06-13 13:30:10.008007006",tz="UTC"),as.POSIXct("2012-06-13 13:30:10.008007007",tz="UTC")))
    result <- dbRun(conn,"2012.06.13T13:30:10.008007006N : 00N")
    record <- assert(record,"download pair nanotimestamp 2012.06.13T13:30:10.008007006N : 00N",result,c(as.POSIXct("2012-06-13 13:30:10.008007006",tz="UTC"),as.POSIXct(NA,tz="UTC")))

    # float
    result <- dbRun(conn,"0.0f:0.1f")
    record <- assert(record,"download pair float0.0f:0.1f",result,c(0,0.1))
    result <- dbRun(conn,"0.0f:float('nan')")
    record <- assert(record,"download pair float 0.0f:float('nan')",result,c(0,NaN))
    result <- dbRun(conn,"0.0f:float('inf')")
    record <- assert(record,"download pair float 0.0f:float('inf')",result,c(0,Inf))
    result <- dbRun(conn,"0.0f:00f")
    record <- assert(record,"download pair float 0.0f:00f",result,c(0,NA_real_))

    # double
    result <- dbRun(conn,"0.0F:0.1F")
    record <- assert(record,"download pair double 0.0F:0.1F",result,c(0,0.1))
    result <- dbRun(conn,"0.0F:00F")
    record <- assert(record,"download pair double 0.0F:00F",result,c(0,NA_real_))

    # string
    result <- dbRun(conn,"`a:`b")
    record <- assert(record,"download pair string `a:`b",result,c("a","b"))
    result <- dbRun(conn,"`a:\"\"")
    record <- assert(record,"download pair string `a:\"\"",result,c("a",NA_character_))

    printTestResult(record)
    conn <- dbClose(conn)
} else {
    stop("connect error in TestDownloadPair.R")
}