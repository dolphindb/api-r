if (!exists("TESTUPLOADVECTOR_R__", envir = .GlobalEnv)){
    TESTUPLOADVECTOR_R__ <- NULL
    source("pub/Test.R")

    library(RDolphinDB)

    # bool
    test$add_case(
        "upload vector bool",
        function(conn){
            state <- dbUpload(conn, "x", list(c(TRUE, FALSE, NA)))
            result <- dbRun(conn, "eqObj(x,[true,false,00b])")
            test$assert(list(state, result), list(TRUE, TRUE))
        }
    )

    # int
    test$add_case(
        "upload vector int",
        function(conn){
            state <- dbUpload(conn, "x", list(c(0L, 2147483647L, -2147483647L, NA)))
            result <- dbRun(conn, "eqObj(x,[0i,2147483647i,-2147483647i,00i])")
            test$assert(list(state, result), list(TRUE, TRUE))
        }
    )

    # date
    test$add_case(
        "upload vector date",
        function(conn){
            state <- dbUpload(conn, "x", list(c(as.Date("1970-01-01"), as.Date(NA))))
            result <- dbRun(conn, "eqObj(x,[1970.01.01d,00d])")
            test$assert(list(state, result), list(TRUE, TRUE))
        }
    )

    # datetime
    test$add_case(
        "upload vector datetime",
        function(conn){
            state <- dbUpload(conn, "x", list(c(as.POSIXct("1970-01-01 13:30:10", tz = "UTC"), as.POSIXct(NA, tz = "UTC"))))
            result <- dbRun(conn, "eqObj(x,[1970.01.01T13:30:10D,00D])")
            test$assert(list(state, result), list(TRUE, TRUE))
        }
    )

    # double
    test$add_case(
        "upload vector double",
        function(conn){
            state <- dbUpload(conn, "x", list(c(0, NaN, NA)))
            result <- dbRun(conn, "eqObj(x,[0F,00F,00F])")
            test$assert(list(state, result), list(TRUE, TRUE))
        }
    )

    # string
    test$add_case(
        "upload vector string",
        function(conn){
            state <- dbUpload(conn, "x", list(c("abc!@#中文 123", "", NA)))
            result <- dbRun(conn, "eqObj(x,[\"abc!@#中文 123\",\"\",\"\"])")
            test$assert(list(state, result), list(TRUE, TRUE))
        }
    )

    # symbol
    test$add_case(
        "upload vector symbol",
        function(conn){
            data <- factor(c("a","a","a","a","a","a","a","a","a","a",NA_character_),levels = c(NA_character_,"a"),exclude = NULL)
            state <- dbUpload(conn, "x", list(data))
            result <- dbRun(conn, "eqObj(x,symbol([`a,`a,`a,`a,`a,`a,`a,`a,`a,`a,\"\"]))")
            test$assert(list(state, result), list(TRUE, TRUE))
        }
    )
    test$add_case(
        "upload vector symbol empty",
        function(conn){
            data <- factor(c())
            state <- dbUpload(conn, "x", list(data))
            result <- dbRun(conn, "eqObj(x,symbol(array(SYMBOL)))")
            test$assert(list(state, result), list(TRUE, TRUE))
        }
    )
    # 不支持上传空向量,不支持上传list
}