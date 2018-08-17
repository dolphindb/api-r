# 
#
# @Author -- Jingtang Zhang
# @Date   -- 2018.8.2, Hangzhou
# @Update -- 2018.8.15, Hangzhou
#
#

library("RDolphinDB")
conn <- dbConnect(DolphinDB(), "192.168.137.132", 8888, "admin", "123456")
if (conn@connected == TRUE) {

    result <- dbRun(conn, "1 2 3")
    print(result)

}
dbClose(conn)
