source("setup/Settings.R")
source("pub/Assert.R")

library(RDolphinDB)

conn <- dbConnect(DolphinDB(),HOST,PORT,USER,PASSWD)
if (conn@connected){
    record <- c(0L,0L)
    # bool
    data <- data.frame(
        a=c(TRUE,FALSE,NA)
    )
    stat <- dbUpload(conn,c("x"),list(data))
    record <- assert(record,"upload table bool",stat,TRUE)
    result1 <- dbRun(conn,"
    data=table([true,false,00b] as `a);
    eqObj(data[`a],x[`a])
    ")
    record <- assert(record,"upload table bool 1",result1,TRUE)
    data <- data.frame(
        a=logical(0)
    )
    stat <- dbUpload(conn,c("x"),list(data))
    record <- assert(record,"upload table bool",stat,TRUE)
    result2 <- dbRun(conn,"
    data=table(array(BOOL) as `a);
    eqObj(data[`a],x[`a])
    ")
    record <- assert(record,"upload table bool 2",result2,TRUE)

    # int
    data <- data.frame(
        a=c(0L,2147483647L,-2147483647L)
    )
    stat <- dbUpload(conn,c("x"),list(data))
    record <- assert(record,"upload table int",stat,TRUE)
    result1 <- dbRun(conn,"
    data=table([0i,2147483647i,-2147483647i] as `a);
    eqObj(data[`a],x[`a])
    ")
    record <- assert(record,"upload table int 1",result1,TRUE)
    data <- data.frame(
        a=integer(0)
    )
    stat <- dbUpload(conn,c("x"),list(data))
    record <- assert(record,"upload table int",stat,TRUE)
    result2 <- dbRun(conn,"
    data=table(array(INT) as `a);
    eqObj(data[`a],x[`a])
    ")
    record <- assert(record,"upload table int 2",result2,TRUE)

    # date
    data <- data.frame(
        a=c(as.Date("1970-01-01"),as.Date(NA))
    )
    stat <- dbUpload(conn,c("x"),list(data))
    record <- assert(record,"upload table date",stat,TRUE)
    result1 <- dbRun(conn,"
    data=table([1970.01.01d,00d] as `a);
    eqObj(data[`a],x[`a])
    ")
    record <- assert(record,"upload table date 1",result1,TRUE)
    data <- data.frame(
        a=as.Date(c())
    )
    stat <- dbUpload(conn,c("x"),list(data))
    record <- assert(record,"upload table date",stat,TRUE)
    result2 <- dbRun(conn,"
    data=table(array(DATE) as `a);
    eqObj(data[`a],x[`a])
    ")
    record <- assert(record,"upload table date 2",result2,TRUE)

    # datetime
    data <- data.frame(
        a=c(as.POSIXct("1970-01-01 13:30:10",tz="UTC"),as.POSIXct(NA,tz="UTC"))
    )
    stat <- dbUpload(conn,c("x"),list(data))
    record <- assert(record,"upload table datetime",stat,TRUE)
    result1 <- dbRun(conn,"
    data=table([1970.01.01T13:30:10D,00D] as `a);
    eqObj(data[`a],x[`a])
    ")
    record <- assert(record,"upload table datetime 1",result1,TRUE)
    data <- data.frame(
        a=as.POSIXct(c())
    )
    stat <- dbUpload(conn,c("x"),list(data))
    record <- assert(record,"upload table datetime",stat,TRUE)
    result2 <- dbRun(conn,"
    data=table(array(DATETIME) as `a);
    eqObj(data[`a],x[`a])
    ")
    record <- assert(record,"upload table datetime 2",result2,TRUE)

    # double
    data <- data.frame(
        a=c(0,NaN)
    )
    stat <- dbUpload(conn,c("x"),list(data))
    record <- assert(record,"upload table double",stat,TRUE)
    result1 <- dbRun(conn,"
    data=table([0F,00F] as `a);
    eqObj(data[`a],x[`a])
    ")
    record <- assert(record,"upload table double 1",result1,TRUE)
    data <- data.frame(
        a=numeric(0)
    )
    stat <- dbUpload(conn,c("x"),list(data))
    record <- assert(record,"upload table double",stat,TRUE)
    result2 <- dbRun(conn,"
    data=table(array(DOUBLE) as `a);
    eqObj(data[`a],x[`a])
    ")
    record <- assert(record,"upload table double 2",result2,TRUE)

    # string
    data <- data.frame(
        a=c("abc!@#中文 123","",NA)
    )
    stat <- dbUpload(conn,c("x"),list(data))
    record <- assert(record,"upload table string",stat,TRUE)
    result1 <- dbRun(conn,"
    data=table([\"abc!@#中文 123\",\"\",\"\"] as `a);
    eqObj(data[`a],x[`a])
    ")
    record <- assert(record,"upload table string 1",result1,TRUE)
    data <- data.frame(
        a=character(0)
    )
    stat <- dbUpload(conn,c("x"),list(data))
    record <- assert(record,"upload table string",stat,TRUE)
    result2 <- dbRun(conn,"
    data=table(array(STRING) as `a);
    eqObj(data[`a],x[`a])
    ")
    record <- assert(record,"upload table string 2",result2,TRUE)

    printTestResult(record)
    conn <- dbClose(conn)
} else {
    stop("connect error in TestUploadTable.R")
}
# todo:arrayvector
# todo:arrayvectortable