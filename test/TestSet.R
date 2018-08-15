# 
#
# @Author -- Jingtang Zhang
# @Date   -- 2018.7.31, Hangzhou
# @Update -- 2018.8.15, Hangzhou
#
#

library("RDolphinDB")
conn <- dbConnect(DolphinDB(), "192.168.137.132", 8888)
if (conn@connected == TRUE) {

    ptm <- proc.time()
    result <- dbRun(conn, "set(1 1.5 2 2.5 2 2.50 2.500 00f NULL)")
    print(result)
    print(class(result))
    print(proc.time() - ptm)
    
}
dbClose(conn)
