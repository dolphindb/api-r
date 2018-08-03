# 
#
# @Author -- Jingtang Zhang
# @Date   -- 2018.7.31, Hangzhou
# @Update -- 2018.8.1, Hangzhou
#
#

library("RDolphinDB")
conn <- dbConnect(DolphinDB(), "192.168.1.32", 8888)
if (conn@connected == TRUE) {

    ptm <- proc.time()
    table <- data.frame(id=c(1,2,3), value=c(2.5, 3.5, 5.5))
    clm <- 1L
    row <- 1L
    testList <- list(table, clm, row)
    result <- dbRpc(conn, "cell", testList)
    print(result)
    print(class(result))
    print(proc.time() - ptm)

    ptm <- proc.time()
    result <- dbRun(conn, "table(1 2 NULL as int, `x`dd`zz as str, 10.8 7.6 3.5 as dbl)")
    print(result)
    print(class(result))
    print(proc.time() - ptm)

}
dbClose(conn)
