source("setup/Settings.R")
source("pub/Assert.R")

library(RDolphinDB)

record <- c(0L,0L)
# host error
conn <- dbConnect(DolphinDB(),"192.1.1.1",PORT)
record <- assert(record,"connect host error",conn@connected,FALSE)

# port error
conn <- dbConnect(DolphinDB(),HOST,22)
record <- assert(record,"connect port error",conn@connected,FALSE)

# user error
conn <- dbConnect(DolphinDB(),HOST,PORT,"dolphindb",PASSWD)
record <- assert(record,"connect user error",conn@connected,TRUE)
conn <- dbClose(conn)

# password error
conn <- dbConnect(DolphinDB(),HOST,PORT,USER,"000000")
record <- assert(record,"connect password error",conn@connected,TRUE)
conn <- dbClose(conn)

printTestResult(record)