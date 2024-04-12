source("setup/Settings.R")
source("pub/Assert.R")

library(RDolphinDB)

conn <- dbConnect(DolphinDB(),HOST,PORT,USER,PASSWD)
if (conn@connected){
    record <- c(0L,0L)
    # bool
    result <- dbRun(conn,"x=matrix([true,false,00b],[true,false,00b]);x.rename!(`row1`row2`row3,`col1`col2);x")
    expect <- matrix(c(TRUE,FALSE,NA,TRUE,FALSE,NA),nrow=3,byrow=FALSE)
    colnames(expect) <- c("col1","col2")
    rownames(expect) <- c("row1","row2","row3")
    record <- assert(record,"download matrix bool 1",result,expect)

    # char
    result <- dbRun(conn,"x=matrix([0c,127c,00c],[0c,127c,00c]);x.rename!(`row1`row2`row3,`col1`col2);x")
    expect <- matrix(c(0L,127L,NA_integer_,0L,127L,NA_integer_),nrow=3,byrow=FALSE)
    colnames(expect) <- c("col1","col2")
    rownames(expect) <- c("row1","row2","row3")
    record <- assert(record,"download matrix char 1",result,expect)

    # short
    result <- dbRun(conn,"x=matrix([0h,32767h,00h],[0h,32767h,00h]);x.rename!(`row1`row2`row3,`col1`col2);x")
    expect <- matrix(c(0L,32767L,NA_integer_,0L,32767L,NA_integer_),nrow=3,byrow=FALSE)
    colnames(expect) <- c("col1","col2")
    rownames(expect) <- c("row1","row2","row3")
    record <- assert(record,"download matrix short 1",result,expect)

    # int
    result <- dbRun(conn,"x=matrix([0i,2147483647i,00i],[0i,2147483647i,00i]);x.rename!(`row1`row2`row3,`col1`col2);x")
    expect <- matrix(c(0L,2147483647L,NA_integer_,0L,2147483647L,NA_integer_),nrow=3,byrow=FALSE)
    colnames(expect) <- c("col1","col2")
    rownames(expect) <- c("row1","row2","row3")
    record <- assert(record,"download matrix int 1",result,expect)

    # long
    result <- dbRun(conn,"x=matrix([0l,9223372036854775807l,00l],[0l,9223372036854775807l,00l]);x.rename!(`row1`row2`row3,`col1`col2);x")
    expect <- matrix(c(0L,9223372036854775807,NA_real_,0L,9223372036854775807,NA_real_),nrow=3,byrow=FALSE)
    colnames(expect) <- c("col1","col2")
    rownames(expect) <- c("row1","row2","row3")
    record <- assert(record,"download matrix long 1",result,expect)

    # date
    result <- dbRun(conn,"x=matrix([1970.01.01d,00d],[1970.01.01d,00d]);x.rename!(`row1`row2,`col1`col2);x")
    expect <- matrix(c("1970-01-01",NA,"1970-01-01",NA),nrow=2,byrow=FALSE)
    colnames(expect) <- c("col1","col2")
    rownames(expect) <- c("row1","row2")
    record <- assert(record,"download matrix date 1",result,expect)

    # month
    result <- dbRun(conn,"x=matrix([1970.01M,00M],[1970.01M,00M]);x.rename!(`row1`row2,`col1`col2);x")
    expect <- matrix(c("1970-01-01",NA,"1970-01-01",NA),nrow=2,byrow=FALSE)
    colnames(expect) <- c("col1","col2")
    rownames(expect) <- c("row1","row2")
    record <- assert(record,"download matrix month 1",result,expect)

    # time
    result <- dbRun(conn,"x=matrix([13:30:10.008t,00t],[13:30:10.008t,00t]);x.rename!(`row1`row2,`col1`col2);x")
    expect <- matrix(c("1970-01-01 13:30:10",NA,"1970-01-01 13:30:10",NA),nrow=2,byrow=FALSE)
    colnames(expect) <- c("col1","col2")
    rownames(expect) <- c("row1","row2")
    record <- assert(record,"download matrix time 1",result,expect)

    # minute
    result <- dbRun(conn,"x=matrix([13:30m,00m],[13:30m,00m]);x.rename!(`row1`row2,`col1`col2);x")
    expect <- matrix(c("1970-01-01 13:30:00",NA,"1970-01-01 13:30:00",NA),nrow=2,byrow=FALSE)
    colnames(expect) <- c("col1","col2")
    rownames(expect) <- c("row1","row2")
    record <- assert(record,"download matrix minute 1",result,expect)

    # second
    result <- dbRun(conn,"x=matrix([13:30:10s,00s],[13:30:10s,00s]);x.rename!(`row1`row2,`col1`col2);x")
    expect <- matrix(c("1970-01-01 13:30:10",NA,"1970-01-01 13:30:10",NA),nrow=2,byrow=FALSE)
    colnames(expect) <- c("col1","col2")
    rownames(expect) <- c("row1","row2")
    record <- assert(record,"download matrix second 1",result,expect)

    # datetime
    result <- dbRun(conn,"x=matrix([2012.06.13T13:30:10D,00D],[2012.06.13T13:30:10D,00D]);x.rename!(`row1`row2,`col1`col2);x")
    expect <- matrix(c("2012-06-13 13:30:10",NA,"2012-06-13 13:30:10",NA),nrow=2,byrow=FALSE)
    colnames(expect) <- c("col1","col2")
    rownames(expect) <- c("row1","row2")
    record <- assert(record,"download matrix datetime 1",result,expect)

    # timestamp
    result <- dbRun(conn,"x=matrix([2012.06.13T13:30:10.008T,00T],[2012.06.13T13:30:10.008T,00T]);x.rename!(`row1`row2,`col1`col2);x")
    expect <- matrix(c("2012-06-13 13:30:10",NA,"2012-06-13 13:30:10",NA),nrow=2,byrow=FALSE)
    colnames(expect) <- c("col1","col2")
    rownames(expect) <- c("row1","row2")
    record <- assert(record,"download matrix timestamp 1",result,expect)

    # nanotime
    result <- dbRun(conn,"x=matrix([13:30:10.008007006n,00n],[13:30:10.008007006n,00n]);x.rename!(`row1`row2,`col1`col2);x")
    expect <- matrix(c("1970-01-01 13:30:10",NA,"1970-01-01 13:30:10",NA),nrow=2,byrow=FALSE)
    colnames(expect) <- c("col1","col2")
    rownames(expect) <- c("row1","row2")
    record <- assert(record,"download matrix nanotime 1",result,expect)

    # nanotimestamp
    result <- dbRun(conn,"x=matrix([2012.06.13T13:30:10.008007006N,00N],[2012.06.13T13:30:10.008007006N,00N]);x.rename!(`row1`row2,`col1`col2);x")
    expect <- matrix(c("2012-06-13 13:30:10",NA,"2012-06-13 13:30:10",NA),nrow=2,byrow=FALSE)
    colnames(expect) <- c("col1","col2")
    rownames(expect) <- c("row1","row2")
    record <- assert(record,"download matrix nanotimestamp 1",result,expect)

    # float
    result <- dbRun(conn,"x=matrix([0.0f,float('nan'),float('inf'),00f],[0.0f,float('nan'),float('inf'),00f]);x.rename!(`row1`row2`row3`row4,`col1`col2);x")
    expect <- matrix(c(0,NaN,Inf,NA_real_,0,NaN,Inf,NA_real_),nrow=4,byrow=FALSE)
    colnames(expect) <- c("col1","col2")
    rownames(expect) <- c("row1","row2","row3","row4")
    record <- assert(record,"download matrix float 1",result,expect)

    # double
    result <- dbRun(conn,"x=matrix([0.0F,00F],[0.0F,00F]);x.rename!(`row1`row2,`col1`col2);x")
    expect <- matrix(c(0,NA_real_,0,NA_real_),nrow=2,byrow=FALSE)
    colnames(expect) <- c("col1","col2")
    rownames(expect) <- c("row1","row2")
    record <- assert(record,"download matrix double 1",result,expect)

    printTestResult(record)
    conn <- dbClose(conn)
} else {
    stop("connect error in TestDownloadMatrix.R")
}