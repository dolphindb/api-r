source("setup/Settings.R")
source("pub/Assert.R")

library(RDolphinDB)

conn <- dbConnect(DolphinDB(),HOST,PORT,USER,PASSWD)
if (conn@connected){
    record <- c(0L,0L)
    # bool
    data <- matrix(c(TRUE,FALSE,NA,TRUE,FALSE,NA),nrow=3,byrow=FALSE)
    colnames(data) <- c("col1","col2")
    rownames(data) <- c("row1","row2","row3")
    stat <- dbUpload(conn,c("x"),list(data))
    record <- assert(record,"upload matrix bool",stat,TRUE)
    result <- dbRun(conn,"
    data=matrix([true false 00b,true false 00b]);
    data.rename!(`row1`row2`row3,`col1`col2);
    eqObj(data,x)
    ")
    record <- assert(record,"upload matrix bool 1",result,TRUE)

    # int
    data <- matrix(c(0L,2147483647L,-2147483647L,NA,0L,2147483647L,-2147483647L,NA),nrow=4,byrow=FALSE)
    colnames(data) <- c("col1","col2")
    rownames(data) <- c("row1","row2","row3","row4")
    stat <- dbUpload(conn,c("x"),list(data))
    record <- assert(record,"upload matrix int",stat,TRUE)
    result <- dbRun(conn,"
    data=matrix([0i 2147483647i -2147483647i 00i,0i 2147483647i -2147483647i 00i]);
    data.rename!(`row1`row2`row3`row4,`col1`col2);
    eqObj(data,x)
    ")
    record <- assert(record,"upload matrix int 1",result,TRUE)

    # double
    data <- matrix(c(0,3.14,-3.14,NA,0,3.14,-3.14,NA),nrow=4,byrow=FALSE)
    colnames(data) <- c("col1","col2")
    rownames(data) <- c("row1","row2","row3","row4")
    stat <- dbUpload(conn,c("x"),list(data))
    record <- assert(record,"upload matrix double",stat,TRUE)
    result <- dbRun(conn,"
    data=matrix([0F 3.14F -3.14F 00F,0F 3.14F -3.14F 00F]);
    data.rename!(`row1`row2`row3`row4,`col1`col2);
    eqObj(data,x)
    ")
    record <- assert(record,"upload matrix double 1",result,TRUE)

    # string
    # not support
    # data <- matrix(c("abc!@#中文 123","",NA,"abc!@#中文 123","",NA),nrow=3,byrow=FALSE)
    # colnames(data) <- c("col1","col2")
    # rownames(data) <- c("row1","row2","row3")
    # stat <- dbUpload(conn,c("x"),list(data))
    # record <- assert(record,"upload matrix string",stat,TRUE)
    # result <- dbRun(conn,"
    # data=matrix([\"abc!@#中文 123\" \"\" \"\",\"abc!@#中文 123\" \"\" \"\"]);
    # data.rename!(`row1`row2`row3,`col1`col2);
    # eqObj(data,x)
    # ")
    # record <- assert(record,"upload matrix string 1",result,TRUE)

    printTestResult(record)
    conn <- dbClose(conn)
} else {
    stop("connect error in TestUploadMatrix.R")
}