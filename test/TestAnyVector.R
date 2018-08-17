# 
#
# @Author -- Jingtang Zhang
# @Date   -- 2018.8.1, Hangzhou
# @Update -- 2018.8.17, Hangzhou
#
#

library("RDolphinDB")
conn <- dbConnect(DolphinDB(), "192.168.137.132", 8888)
if (conn@connected == TRUE) {

    ptm <- proc.time()
    result <- dbRun(conn, "(1, table(2018.07.22 2018.08.21 as date, `Hello`World as str),5.5, 1 2 3, 2012.06M)")
    print(result)
    print(class(result))
    print(proc.time() - ptm)

}
dbClose(conn)
