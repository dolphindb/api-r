# 
#
# @Author -- Jingtang Zhang
# @Date   -- 2018.8.2, Hangzhou
#
#

library("RDolphinDB")
conn <- dbConnect(DolphinDB(), "192.168.1.32", 8888)
if (conn@connected == TRUE) {

    ptm <- proc.time()
    keys <- c("x", "y", "z")
    args <- list(5, c(2L, 3L), "666")
    stat <- dbUpload(conn, keys, args)
    if (stat) {
        result <- dbRun(conn, "x")
        print(result)
        print(class(result))

        result <- dbRun(conn, "y")
        print(result)
        print(class(result))

        result <- dbRun(conn, "z")
        print(result)
        print(class(result))
    }
    
    print(proc.time() - ptm)

}
dbClose(conn)
