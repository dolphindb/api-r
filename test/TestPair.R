# 
#
# @Author -- Jingtang Zhang
# @Date   -- 2018.8.17, Hangzhou
# @Update -- 2018.8.17, Hangzhou
#
#

library("RDolphinDB")
conn <- dbConnect(DolphinDB(), "192.168.137.132", 8888)
if (conn@connected == TRUE) {
  
    ptm <- proc.time()
    result <- dbRun(conn, "4:8")
    print(result)
    print(class(result))
    print(proc.time() - ptm)
    
    ptm <- proc.time()
    result <- dbRun(conn, "3.5:6.8")
    print(result)
    print(class(result))
    print(proc.time() - ptm)

    ptm <- proc.time()
    result <- dbRun(conn, "`Hello:`World")
    print(result)
    print(class(result))
    print(proc.time() - ptm)

}
dbClose(conn)
