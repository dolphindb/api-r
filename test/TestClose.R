source("setup/Settings.R")
source("pub/Assert.R")

library(RDolphinDB)

record <- c(0L,0L)
# close
conn <- dbConnect(DolphinDB(),HOST,PORT)
conn <- dbClose(conn)
record <- assert(record,"connect close",conn@connected,FALSE)

# already closed
conn <- dbConnect(DolphinDB(),HOST,PORT)
conn <- dbClose(conn)
conn <- dbClose(conn)
record <- assert(record,"connect close",conn@connected,FALSE)

printTestResult(record)