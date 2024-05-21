if (!exists("TESTUPLOADSCALAR_R__", envir = .GlobalEnv)){
    TESTUPLOADSCALAR_R__ <- NULL
    source("pub/Test.R")

    library(RDolphinDB)

    # void
    test$add_case(
        "upload scalar void",
        function(conn){
            state <- dbUpload(conn, "x1", list(NA))
            result1 <- dbRun(conn, "eqObj(x1,NULL)")
            test$assert(list(state, result1), list(TRUE, TRUE))
        }
    )

    # bool
    test$add_case(
        "upload scalar bool",
        function(conn){
            state <- dbUpload(conn, c("x1", "x2"), list(TRUE, FALSE))
            result1 <- dbRun(conn, "eqObj(x1,true)")
            result2 <- dbRun(conn, "eqObj(x2,false)")
            test$assert(list(state, result1, result2), list(TRUE, TRUE, TRUE))
        }
    )

    # int
    test$add_case(
        "upload scalar int",
        function(conn){
            state <- dbUpload(conn, c("x1", "x2", "x3"), list(0L, 2147483647L, -2147483647L))
            result1 <- dbRun(conn, "eqObj(x1,0i)")
            result2 <- dbRun(conn, "eqObj(x2,2147483647i)")
            result3 <- dbRun(conn, "eqObj(x3,-2147483647i)")
            test$assert(list(state, result1, result2, result3), list(TRUE, TRUE, TRUE, TRUE))
        }
    )

    # date
    test$add_case(
        "upload scalar date",
        function(conn){
            state <- dbUpload(conn, c("x1", "x2"), list(as.Date("1970-01-01"), as.Date(NA)))
            result1 <- dbRun(conn, "eqObj(x1,1970.01.01d)")
            result2 <- dbRun(conn, "eqObj(x2,00d)")
            test$assert(list(state, result1, result2), list(TRUE, TRUE, TRUE))
        }
    )

    # datetime
    test$add_case(
        "upload scalar datetime",
        function(conn){
            state <- dbUpload(conn, c("x1", "x2"), list(as.POSIXct("1970-01-01 13:30:10", tz = "UTC"), as.POSIXct(NA, tz = "UTC")))
            result1 <- dbRun(conn, "eqObj(x1,1970.01.01T13:30:10D)")
            result2 <- dbRun(conn, "eqObj(x2,00D)")
            test$assert(list(state, result1, result2), list(TRUE, TRUE, TRUE))
        }
    )

    # double
    test$add_case(
        "upload scalar double",
        function(conn){
            state <- dbUpload(conn, c("x1", "x2"), list(0, NaN))
            result1 <- dbRun(conn, "eqObj(x1,0F)")
            result2 <- dbRun(conn, "eqObj(x2,00F)")
            test$assert(list(state, result1, result2), list(TRUE, TRUE, TRUE))
        }
    )

    # string
    test$add_case(
        "upload scalar string",
        function(conn){
            state <- dbUpload(conn, c("x1", "x2"), list("abc!@#中文 123", ""))
            result1 <- dbRun(conn, "eqObj(x1,\"abc!@#中文 123\")")
            result2 <- dbRun(conn, "eqObj(x2,\"\")")
            test$assert(list(state, result1, result2), list(TRUE, TRUE, TRUE))
        }
    )
}