# 
#
# @Author -- Jingtang Zhang
# @Date   -- 2018.8.1, Hangzhou
#
#

library("RDolphinDB")
conn <- dbConnect(DolphinDB(), "192.168.1.32", 8888)
if (conn@connected == TRUE) {

    ptm <- proc.time()
    result <- dbRun(conn, "(1,2,3,4,5.5)")
    print(result)
    print(class(result))
    print(proc.time() - ptm)

    ptm <- proc.time()
    result <- dbRun(conn, "second(2012.06.13 13:30:10)")
    print(result)
    print(class(result))
    print(proc.time() - ptm)

    ptm <- proc.time()
    result <- dbRun(conn, "month(2016.02.14)")
    print(result)
    print(class(result))
    print(proc.time() - ptm)

}
dbClose(conn)
