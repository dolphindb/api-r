source("setup/Settings.R")
source("pub/Assert.R")

library(RDolphinDB)

conn <- dbConnect(DolphinDB(),HOST,PORT,USER,PASSWD)
if (conn@connected){
    record <- c(0L,0L)
    # void
    stat <- dbUpload(conn,c("x1","x2"),list(NA,NaN))
    record <- assert(record,"upload scalar void",stat,TRUE)
    result1 <- dbRun(conn,"eqObj(x1,NULL)")
    record <- assert(record,"upload scalar void NA",result1,TRUE)
    result2 <- dbRun(conn,"eqObj(x2,NULL)")
    record <- assert(record,"upload scalar void NaN",result2,TRUE)

    # int
    stat <- dbUpload(conn,c("x1","x2","x3"),list(0L,2147483647L,-2147483647L))
    record <- assert(record,"upload scalar int",stat,TRUE)
    result1 <- dbRun(conn,"eqObj(x1,0i)")
    record <- assert(record,"upload scalar int 1",result1,TRUE)
    result2 <- dbRun(conn,"eqObj(x2,2147483647i)")
    record <- assert(record,"upload scalar int 2",result2,TRUE)
    result3 <- dbRun(conn,"eqObj(x3,-2147483647i)")
    record <- assert(record,"upload scalar int 3",result3,TRUE)

    # date
    # stat <- dbUpload(conn,c("x1","x2"),list(as.Date("1970-01-01"),as.Date(NA)))
    # record <- assert(record,"upload scalar date",stat,TRUE)
    # result1 <- dbRun(conn,"eqObj(x1,1970.01.01d)")
    # record <- assert(record,"upload scalar date 1",result1,TRUE)
    # result2 <- dbRun(conn,"eqObj(x2,00d)")
    # record <- assert(record,"upload scalar date 2",result2,TRUE)

    # time
    # stat <- dbUpload(conn,c("x1"),list(as.POSIXct("1970-01-01 13:30:10",tz="UTC")))
    # record <- assert(record,"upload scalar time",stat,TRUE)

    # double
    stat <- dbUpload(conn,c("x1","x2"),list(0,Inf))
    record <- assert(record,"upload scalar double",stat,TRUE)
    result1 <- dbRun(conn,"eqObj(x1,0F)")
    record <- assert(record,"upload scalar double 1",result1,TRUE)
    # result2 <- dbRun(conn,"eqObj(x2,float(\"inf\"))")
    # record <- assert(record,"upload scalar double 2",result2,TRUE)

    # string
    stat <- dbUpload(conn,c("x1","x2"),list("abc!@#中文 123",""))
    record <- assert(record,"upload scalar string",stat,TRUE)
    result1 <- dbRun(conn,"eqObj(x1,\"abc!@#中文 123\")")
    record <- assert(record,"upload scalar string 1",result1,TRUE)
    result2 <- dbRun(conn,"eqObj(x2,\"\")")
    record <- assert(record,"upload scalar string 2",result2,TRUE)

    printTestResult(record)
    conn <- dbClose(conn)
} else {
    stop("connect error in TestUploadScalar.R")
}