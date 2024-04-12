source("setup/Settings.R")
source("pub/Assert.R")

library(RDolphinDB)

conn <- dbConnect(DolphinDB(),HOST,PORT,USER,PASSWD)
if (conn@connected){
    record <- c(0L,0L)
    . <- dbRun(conn,"
        def test_rpc0(){
            return true
        }

        def test_rpc1(x){
            return true
        }

        def test_rpc2(x,y){
            return true
        }
    ")

    # 0 params
    result <- dbRpc(conn,"test_rpc0",list())
    record <- assert(record,"test dbRpc 0 params",result,TRUE)

    # 1 params
    result <- dbRpc(conn,"test_rpc1",list(1))
    record <- assert(record,"test dbRpc 1 params",result,TRUE)

    # 2 params
    result <- dbRpc(conn,"test_rpc2",list(1,2))
    record <- assert(record,"test dbRpc 2 params",result,TRUE)

    # part apply
    result <- dbRpc(conn,"test_rpc2{0}",list(1))
    record <- assert(record,"test dbRpc part apply",result,TRUE)

    result <-

    printTestResult(record)
    conn <- dbClose(conn)
} else {
    stop("connect error in TestRpcBasic.R")
}