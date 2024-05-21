if (!exists("TESTRUNSET_R__", envir = .GlobalEnv)){
    TESTRUNSET_R__ <- NULL
    source("pub/Test.R")

    library(RDolphinDB)

    # char
    test$add_case(
        "download set char set([0c,127c,00c])",
        function(conn){
            result <- dbRun(conn, "set([0c,127c,00c])")
            test$assert(result, c(0L, 127L, NA_integer_), mode = "in")
        }
    )
    test$add_case(
        "download set char set(array(CHAR))",
        function(conn){
            result <- dbRun(conn, "set(array(CHAR))")
            test$assert(result, integer(0))
        }
    )

    # short
    test$add_case(
        "download set short set([0h,32767h,00h])",
        function(conn){
            result <- dbRun(conn, "set([0h,32767h,00h])")
            test$assert(result, c(0L, 32767L, NA_integer_), mode = "in")
        }
    )
    test$add_case(
        "download set short set(array(SHORT))",
        function(conn){
            result <- dbRun(conn, "set(array(SHORT))")
            test$assert(result, integer(0))
        }
    )

    # int
    test$add_case(
        "download set int set([0i,2147483647i,00i])",
        function(conn){
            result <- dbRun(conn, "set([0i,2147483647i,00i])")
            test$assert(result, c(0L, 2147483647L, NA_integer_), mode = "in")
        }
    )
    test$add_case(
        "download set int set(array(INT))",
        function(conn){
            result <- dbRun(conn, "set(array(INT))")
            test$assert(result, integer(0))
        }
    )

    # long
    test$add_case(
        "download set long set([0l,9223372036854775807l,00l])",
        function(conn){
            result <- dbRun(conn, "set([0l,9223372036854775807l,00l])")
            test$assert(result, c(0L, 9223372036854775807, NA_real_), mode = "in")
        }
    )
    test$add_case(
        "download set long set(array(LONG))",
        function(conn){
            result <- dbRun(conn, "set(array(LONG))")
            test$assert(result, numeric(0))
        }
    )

    # date
    test$add_case(
        "download set date set([1970.01.01d,00d])",
        function(conn){
            result <- dbRun(conn, "set([1970.01.01d,00d])")
            test$assert(result, c(as.Date("1970-01-01"), NA), mode = "in")
        }
    )
    test$add_case(
        "download set date set(array(DATE))",
        function(conn){
            result <- dbRun(conn, "set(array(DATE))")
            test$assert(result, as.Date(c()))
        }
    )

    # month
    test$add_case(
        "download set month set([1970.01M,00M])",
        function(conn){
            result <- dbRun(conn, "set([1970.01M,00M])")
            test$assert(result, c(as.Date("1970-01-01"), NA), mode = "in")
        }
    )
    test$add_case(
        "download set month set(array(MONTH))",
        function(conn){
            result <- dbRun(conn, "set(array(MONTH))")
            test$assert(result, as.Date(c()))
        }
    )

    # time
    test$add_case(
        "download set time set([13:30:10.008t,00t])",
        function(conn){
            result <- dbRun(conn, "set([13:30:10.008t,00t])")
            test$assert(result, c(as.POSIXct("1970-01-01 13:30:10.008", tz = "UTC"), as.POSIXct(NA, tz = "UTC")), mode = "in")
        }
    )
    test$add_case(
        "download set time set(array(TIME))",
        function(conn){
            result <- dbRun(conn, "set(array(TIME))")
            test$assert(result, as.POSIXct(c(), tz = "UTC"))
        }
    )

    # minute
    test$add_case(
        "download set minute set([13:30m,00m])",
        function(conn){
            result <- dbRun(conn, "set([13:30m,00m])")
            test$assert(result, c(as.POSIXct("1970-01-01 13:30:00", tz = "UTC"), as.POSIXct(NA, tz = "UTC")), mode = "in")
        }
    )
    test$add_case(
        "download set minute set(array(MINUTE))",
        function(conn){
            result <- dbRun(conn, "set(array(MINUTE))")
            test$assert(result, as.POSIXct(c(), tz = "UTC"))
        }
    )

    # second
    test$add_case(
        "download set second set([13:30:10s,00s])",
        function(conn){
            result <- dbRun(conn, "set([13:30:10s,00s])")
            test$assert(result, c(as.POSIXct("1970-01-01 13:30:10", tz = "UTC"), as.POSIXct(NA, tz = "UTC")), mode = "in")
        }
    )
    test$add_case(
        "download set second set(array(SECOND))",
        function(conn){
            result <- dbRun(conn, "set(array(SECOND))")
            test$assert(result, as.POSIXct(c(), tz = "UTC"))
        }
    )

    # datetime
    test$add_case(
        "download set datetime set([2012.06.13T13:30:10D,00D])",
        function(conn){
            result <- dbRun(conn, "set([2012.06.13T13:30:10D,00D])")
            test$assert(result, c(as.POSIXct("2012-06-13 13:30:10", tz = "UTC"), as.POSIXct(NA, tz = "UTC")), mode = "in")
        }
    )
    test$add_case(
        "download set datetime set(array(DATETIME))",
        function(conn){
            result <- dbRun(conn, "set(array(DATETIME))")
            test$assert(result, as.POSIXct(c(), tz = "UTC"))
        }
    )

    # timestamp
    test$add_case(
        "download set timestamp set([2012.06.13T13:30:10.008T,00T])",
        function(conn){
            result <- dbRun(conn, "set([2012.06.13T13:30:10.008T,00T])")
            test$assert(result, c(as.POSIXct("2012-06-13 13:30:10.008", tz = "UTC"), as.POSIXct(NA, tz = "UTC")), mode = "in")
        }
    )
    test$add_case(
        "download set timestamp set(array(TIMESTAMP))",
        function(conn){
            result <- dbRun(conn, "set(array(TIMESTAMP))")
            test$assert(result, as.POSIXct(c(), tz = "UTC"))
        }
    )

    # nanotime
    test$add_case(
        "download set nanotime set([13:30:10.008007006n,00n])",
        function(conn){
            result <- dbRun(conn, "set([13:30:10.008007006n,00n])")
            test$assert(result, c(as.POSIXct("1970-01-01 13:30:10.008007006", tz = "UTC"), as.POSIXct(NA, tz = "UTC")), mode = "in")
        }
    )
    test$add_case(
        "download set nanotime set(array(NANOTIME))",
        function(conn){
            result <- dbRun(conn, "set(array(NANOTIME))")
            test$assert(result, as.POSIXct(c(), tz = "UTC"))
        }
    )

    # nanotimestamp
    test$add_case(
        "download set nanotimestamp set([2012.06.13T13:30:10.008007006N,00N])",
        function(conn){
            result <- dbRun(conn, "set([2012.06.13T13:30:10.008007006N,00N])")
            test$assert(result, c(as.POSIXct(NA, tz = "UTC"), as.POSIXct("2012-06-13 13:30:10.008007006", tz = "UTC")))
        }
    )
    test$add_case(
        "download set nanotimestamp set(array(NANOTIMESTAMP))",
        function(conn){
            result <- dbRun(conn, "set(array(NANOTIMESTAMP))")
            test$assert(result, as.POSIXct(c(), tz = "UTC"))
        }
    )

    # float
    test$add_case(
        "download set float set([0.0f,float('nan'),float('inf'),00f])",
        function(conn){
            result <- dbRun(conn, "set([0.0f,float('nan'),float('inf'),00f])")
            test$assert(result, c(0, NaN, Inf, NA_real_), mode = "in")
        }
    )
    test$add_case(
        "download set float set(array(FLOAT))",
        function(conn){
            result <- dbRun(conn, "set(array(FLOAT))")
            test$assert(result, numeric(0))
        }
    )

    # double
    test$add_case(
        "download set double set([0.0F,00F])",
        function(conn){
            result <- dbRun(conn, "set([0.0F,00F])")
            test$assert(result, c(0, NA_real_), mode = "in")
        }
    )
    test$add_case(
        "download set double set(array(DOUBLE))",
        function(conn){
            result <- dbRun(conn, "set(array(DOUBLE))")
            test$assert(result, numeric(0))
        }
    )

    # string
    test$add_case(
        "download set string set([`a,\"\"])",
        function(conn){
            result <- dbRun(conn, "set([`a,\"\"])")
            test$assert(result, c("a", NA_character_), mode = "in")
        }
    )
    test$add_case(
        "download set string set(array(STRING))",
        function(conn){
            result <- dbRun(conn, "set(array(STRING))")
            test$assert(result, character(0))
        }
    )

    # symbol
    test$add_case(
        "download set symbol set(symbol(`a`a`a`a`a`a`a`a`a`a`b))",
        function(conn){
            result <- dbRun(conn, "set(symbol(`a`a`a`a`a`a`a`a`a`a`b))")
            test$assert(result, c("a", "b"), mode = "in")
        }
    )
    test$add_case(
        "download set symbol set(array(SYMBOL))",
        function(conn){
            result <- dbRun(conn, "set(array(SYMBOL))")
            test$assert(result, character(0))
        }
    )
}