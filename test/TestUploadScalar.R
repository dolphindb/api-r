source("setup/Settings.R")
source("pub/Assert.R")

library(RDolphinDB)

conn <- dbConnect(DolphinDB(),HOST,PORT,USER,PASSWD)
if (conn@connected){
    record <- c(0L,0L)
    # void
    stat <- dbUpload(conn,c("x1"),list(NA))
    record <- assert(record,"upload scalar void",stat,TRUE)
    result1 <- dbRun(conn,"eqObj(x1,NULL)")
    record <- assert(record,"upload scalar void NA",result1,TRUE)

    # bool
    stat <- dbUpload(conn,c("x1","x2"),list(TRUE,FALSE))
    record <- assert(record,"upload scalar bool",stat,TRUE)
    result1 <- dbRun(conn,"eqObj(x1,true)")
    record <- assert(record,"upload scalar bool true",result1,TRUE)
    result2 <- dbRun(conn,"eqObj(x2,false)")
    record <- assert(record,"upload scalar bool false",result2,TRUE)

    # int
    stat <- dbUpload(conn,c("x1","x2","x3"),list(0L,2147483647L,-2147483647L))
    record <- assert(record,"upload scalar int",stat,TRUE)
    result1 <- dbRun(conn,"eqObj(x1,0i)")
    record <- assert(record,"upload scalar int 0L",result1,TRUE)
    result2 <- dbRun(conn,"eqObj(x2,2147483647i)")
    record <- assert(record,"upload scalar int 2147483647L",result2,TRUE)
    result3 <- dbRun(conn,"eqObj(x3,-2147483647i)")
    record <- assert(record,"upload scalar int -2147483647L",result3,TRUE)

    # date
    stat <- dbUpload(conn,c("x1","x2"),list(as.Date("1970-01-01"),as.Date(NA)))
    record <- assert(record,"upload scalar date",stat,TRUE)
    result1 <- dbRun(conn,"eqObj(x1,1970.01.01d)")
    record <- assert(record,"upload scalar date as.Date(\"1970-01-01\")",result1,TRUE)
    result2 <- dbRun(conn,"eqObj(x2,00d)")
    record <- assert(record,"upload scalar date as.Date(NA)",result2,TRUE)

    # datetime
    stat <- dbUpload(conn,c("x1","x2"),list(as.POSIXct("1970-01-01 13:30:10",tz="UTC"),as.POSIXct(NA,tz="UTC")))
    record <- assert(record,"upload scalar time",stat,TRUE)
    result1 <- dbRun(conn,"eqObj(x1,1970.01.01T13:30:10D)")
    record <- assert(record,"upload scalar datetime as.POSIXct(\"1970-01-01 13:30:10\",tz=\"UTC\")",result1,TRUE)
    result2 <- dbRun(conn,"eqObj(x2,00D)")
    record <- assert(record,"upload scalar datetime as.POSIXct(NA,tz=\"UTC\")",result2,TRUE)

    # double
    stat <- dbUpload(conn,c("x1","x2"),list(0,NaN))
    record <- assert(record,"upload scalar double",stat,TRUE)
    result1 <- dbRun(conn,"eqObj(x1,0F)")
    record <- assert(record,"upload scalar double 0",result1,TRUE)
    result2 <- dbRun(conn,"eqObj(x2,00F)")
    record <- assert(record,"upload scalar double NaN",result2,TRUE)

    # string
    stat <- dbUpload(conn,c("x1","x2"),list("abc!@#中文 123",""))
    record <- assert(record,"upload scalar string",stat,TRUE)
    result1 <- dbRun(conn,"eqObj(x1,\"abc!@#中文 123\")")
    record <- assert(record,"upload scalar string \"abc!@#中文 123\"",result1,TRUE)
    result2 <- dbRun(conn,"eqObj(x2,\"\")")
    record <- assert(record,"upload scalar string \"\"",result2,TRUE)

    printTestResult(record)
    conn <- dbClose(conn)
} else {
    stop("connect error in TestUploadScalar.R")
}