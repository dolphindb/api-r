source("setup/Settings.R")
source("pub/Assert.R")

library(RDolphinDB)

conn <- dbConnect(DolphinDB(),HOST,PORT,USER,PASSWD)
if (conn@connected){
    record <- c(0L,0L)
    # bool
    stat <- dbUpload(conn,c("x"),list(c(TRUE,FALSE,NA)))
    record <- assert(record,"upload vector bool",stat,TRUE)
    result <- dbRun(conn,"eqObj(x,[true,false,00b])")
    record <- assert(record,"upload vector bool c(TRUE,FALSE,NA)",result,TRUE)

    # int
    stat <- dbUpload(conn,c("x"),list(c(0L,2147483647L,-2147483647L,NA)))
    record <- assert(record,"upload vector int",stat,TRUE)
    result <- dbRun(conn,"eqObj(x,[0i,2147483647i,-2147483647i,00i])")
    record <- assert(record,"upload vector int 1",result,TRUE)

    # date
    stat <- dbUpload(conn,c("x"),list(c(as.Date("1970-01-01"),as.Date(NA))))
    record <- assert(record,"upload vector date",stat,TRUE)
    result <- dbRun(conn,"eqObj(x,[1970.01.01d,00d])")
    record <- assert(record,"upload vector date 1",result,TRUE)

    # datetime
    stat <- dbUpload(conn,c("x"),list(c(as.POSIXct("1970-01-01 13:30:10",tz="UTC"),as.POSIXct(NA,tz="UTC"))))
    record <- assert(record,"upload vector time",stat,TRUE)
    result <- dbRun(conn,"eqObj(x,[1970.01.01T13:30:10D,00D])")
    record <- assert(record,"upload vector time 1",result,TRUE)

    # double
    stat <- dbUpload(conn,c("x"),list(c(0,NaN,NA)))
    record <- assert(record,"upload vector double",stat,TRUE)
    result <- dbRun(conn,"eqObj(x,[0F,00F,00F])")
    record <- assert(record,"upload vector double 1",result,TRUE)

    # string
    stat <- dbUpload(conn,c("x"),list(c("abc!@#中文 123","",NA)))
    record <- assert(record,"upload vector string",stat,TRUE)
    result <- dbRun(conn,"eqObj(x,[\"abc!@#中文 123\",\"\",\"\"])")
    record <- assert(record,"upload vector string 1",result,TRUE)

    printTestResult(record)
    conn <- dbClose(conn)
} else {
    stop("connect error in TestUploadVector.R")
}
# 不支持上传空向量,不支持上传list