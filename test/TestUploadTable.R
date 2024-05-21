if (!exists("TESTUPLOADTABLE_R__", envir = .GlobalEnv)){
    TESTUPLOADTABLE_R__ <- NULL
    source("pub/Test.R")

    library(RDolphinDB)

    # bool
    test$add_case(
        "upload table bool",
        function(conn){
            data <- data.frame(
                a = c(TRUE, FALSE, NA)
            )
            state <- dbUpload(conn, "x", list(data))
            result <- dbRun(conn, "
                data=table([true,false,00b] as `a);
                eqObj(data[`a],x[`a])
            ")
            test$assert(list(state, result), list(TRUE, TRUE))
        }
    )
    test$add_case(
        "upload table bool empty",
        function(conn){
            data <- data.frame(
                a = logical(0)
            )
            state <- dbUpload(conn, "x", list(data))
            result <- dbRun(conn, "
                data=table(array(BOOL) as `a);
                eqObj(data[`a],x[`a])
            ")
            test$assert(list(state, result), list(TRUE, TRUE))
        }
    )

    # int
    test$add_case(
        "upload table int",
        function(conn){
            data <- data.frame(
                a = c(0L, 2147483647L, -2147483647L)
            )
            state <- dbUpload(conn, "x", list(data))
            result <- dbRun(conn, "
                data=table([0i,2147483647i,-2147483647i] as `a);
                eqObj(data[`a],x[`a])
            ")
            test$assert(list(state, result), list(TRUE, TRUE))
        }
    )
    test$add_case(
        "upload table int empty",
        function(conn){
            data <- data.frame(
                a = integer(0)
            )
            state <- dbUpload(conn, "x", list(data))
            result <- dbRun(conn, "
                data=table(array(INT) as `a);
                eqObj(data[`a],x[`a])
            ")
            test$assert(list(state, result), list(TRUE, TRUE))
        }
    )

    # date
    test$add_case(
        "upload table date",
        function(conn){
            data <- data.frame(
                a = c(as.Date("1970-01-01"), as.Date(NA))
            )
            state <- dbUpload(conn, "x", list(data))
            result <- dbRun(conn, "
                data=table([1970.01.01d,00d] as `a);
                eqObj(data[`a],x[`a])
            ")
            test$assert(list(state, result), list(TRUE, TRUE))
        }
    )
    test$add_case(
        "upload table date empty",
        function(conn){
            data <- data.frame(
                a = as.Date(c())
            )
            state <- dbUpload(conn, "x", list(data))
            result <- dbRun(conn, "
                data=table(array(DATE) as `a);
                eqObj(data[`a],x[`a])
            ")
            test$assert(list(state, result), list(TRUE, TRUE))
        }
    )

    # datetime
    test$add_case(
        "upload table datetime",
        function(conn){
            data <- data.frame(
                a = c(as.POSIXct("1970-01-01 13:30:10", tz = "UTC"), as.POSIXct(NA, tz = "UTC"))
            )
            state <- dbUpload(conn, "x", list(data))
            result <- dbRun(conn, "
                data=table([1970.01.01T13:30:10D,00D] as `a);
                eqObj(data[`a],x[`a])
            ")
            test$assert(list(state, result), list(TRUE, TRUE))
        }
    )
    test$add_case(
        "upload table datetime empty",
        function(conn){
            data <- data.frame(
                a = as.POSIXct(c())
            )
            state <- dbUpload(conn, "x", list(data))
            result <- dbRun(conn, "
                data=table(array(DATETIME) as `a);
                eqObj(data[`a],x[`a])
            ")
            test$assert(list(state, result), list(TRUE, TRUE))
        }
    )

    # double
    test$add_case(
        "upload table double",
        function(conn){
            data <- data.frame(
                a = c(0, NaN)
            )
            state <- dbUpload(conn, "x", list(data))
            result <- dbRun(conn, "
                data=table([0F,00F] as `a);
                eqObj(data[`a],x[`a])
            ")
            test$assert(list(state, result), list(TRUE, TRUE))
        }
    )
    test$add_case(
        "upload table double empty",
        function(conn){
            data <- data.frame(
                a = numeric(0)
            )
            state <- dbUpload(conn, "x", list(data))
            result <- dbRun(conn, "
                data=table(array(DOUBLE) as `a);
                eqObj(data[`a],x[`a])
            ")
            test$assert(list(state, result), list(TRUE, TRUE))
        }
    )

    # string
    test$add_case(
        "upload table string",
        function(conn){
            data <- data.frame(
                a = c("abc!@#中文 123", "", NA)
            )
            state <- dbUpload(conn, "x", list(data))
            result <- dbRun(conn, "
                data=table([\"abc!@#中文 123\",\"\",\"\"] as `a);
                eqObj(data[`a],x[`a])
            ")
            test$assert(list(state, result), list(TRUE, TRUE))
        }
    )
    test$add_case(
        "upload table symbol",
        function(conn){
            data <- data.frame(
                a = factor(c("a","a","a","a","a","a","a","a","a","a",NA_character_),levels = c(NA_character_,"a"),exclude = NULL)
            )
            state <- dbUpload(conn, "x", list(data))
            result <- dbRun(conn, "
                data=table(symbol([`a,`a,`a,`a,`a,`a,`a,`a,`a,`a,\"\"]) as `a);
                eqObj(data[`a],x[`a])
            ")
            test$assert(list(state, result), list(TRUE, TRUE))
        }
    )

    # symbol
    test$add_case(
        "upload table symbol",
        function(conn){
            data <- data.frame(
                a = character(0)
            )
            state <- dbUpload(conn, "x", list(data))
            result <- dbRun(conn, "
                data=table(array(STRING) as `a);
                eqObj(data[`a],x[`a])
            ")
            test$assert(list(state, result), list(TRUE, TRUE))
        }
    )
    test$add_case(
        "upload table symbol empty",
        function(conn){
            data <- data.frame(
                a = factor()
            )
            state <- dbUpload(conn, "x", list(data))
            result <- dbRun(conn, "
                data=table(array(SYMBOL) as `a);
                eqObj(data[`a],x[`a])
            ")
            test$assert(list(state, result), list(TRUE, TRUE))
        }
    )
    # todo:arrayvector
    # todo:arrayvectortable
}