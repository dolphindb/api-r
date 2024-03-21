source("setup/Settings.R")
source("pub/Assert.R")

library(RDolphinDB)

conn <- dbConnect(DolphinDB(),HOST,PORT,USER,PASSWD)
if (conn@connected){
    record <- c(0L,0L)
    # int
    # todo1:第一行第二列的数据变为na?未提jira
    # todo2:带列名和行名的矩阵上传后，下载回来报错
    data <- matrix(c(0L,2147483647L,-2147483647L,NA,0L,2147483647L,-2147483647L,NA),nrow=4,byrow=FALSE)
    colnames(data) <- c("col1","col2")
    rownames(data) <- c("row1","row2","row3","row4")
    stat <- dbUpload(conn,c("x"),list(data))
    record <- assert(record,"upload matrix int",stat,TRUE)
    # result <- dbRun(conn,"
    # data=matrix([0i 2147483647i -2147483647i 00i,0i 2147483647i -2147483647i 00i]);
    # //data.rename!(`row1`row2`row3`row4,`col1`col2);
    # eqObj(data,x)
    # ")
    print(data)
    print(dbRun(conn,"x"))

    printTestResult(record)
    conn <- dbClose(conn)
} else {
    stop("connect error in TestUploadMatrix.R")
}