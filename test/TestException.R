# 
#
# @Author -- Jingtang Zhang
# @Date   -- 2018.8.1, Hangzhou
# @Update -- 2018.8.15, Hangzhou
#
#

library("RDolphinDB")
conn <- dbConnect(DolphinDB(), "192.168.137.132", 8888)
if (conn@connected == TRUE) {

    ptm <- proc.time()
    result <- dbRun(conn, "(1,2,3,4,5.5)")
    print(result)
    print(class(result))
    print(proc.time() - ptm)

}
dbClose(conn)
