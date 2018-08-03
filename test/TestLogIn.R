# 
#
# @Author -- Jingtang Zhang
# @Date   -- 2018.8.2, Hangzhou
#
#

library("RDolphinDB")
conn <- dbConnect(DolphinDB(), "192.168.1.32", 8888, "admin", "123456")
if (conn@connected == TRUE) {

    result <- dbRun(conn, "1 2 3")
    print(result)

}
dbClose(conn)
