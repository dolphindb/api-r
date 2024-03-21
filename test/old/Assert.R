# 
#
# @Author -- Jingtang Zhang
# @Date   -- 2018.8.18, Ningbo
# @Update -- 2018.8.19, Ningbo
#
#

# Config IP address and port who is running DolphinDB server
ip_addr <- "192.168.0.54"
port <- 8848

# Count all cases, print error message
assert <- function(record, item, target, current) {
    print(all.equal(target, current))
    if (TRUE == all.equal(target, current)) {
        record[1] <- record[1] + 1L
    } else {
        print(paste("ITEM:", item, "FAILED"))
    }
    record[2] <- record[2] + 1L
    return (record)
}

# Print testing result
printer <- function(record) {
    msg <- paste("Build Failed:", as.character(record[2]-record[1]), "/", as.character(record[2]))
    print(msg, quote = FALSE)
}
