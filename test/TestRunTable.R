if (!exists("TESTRUNTABLE_R__", envir = .GlobalEnv)){
    TESTRUNTABLE_R__ <- NULL
    source("pub/Test.R")

    library(RDolphinDB)

    # bool
    test$add_case(
        "download table bool",
        function(conn){
            result <- dbRun(conn, "table([true,false,00b] as `a)")
            expect <- data.frame(
                a = c(TRUE, FALSE, NA)
            )
            test$assert(result, expect)
        }
    )
    test$add_case(
        "download table bool empty",
        function(conn){
            result <- dbRun(conn, "table(100:0,[`a],[BOOL])")
            expect <- data.frame(
                a = logical(0)
            )
            test$assert(result, expect)
        }
    )

    # char
    test$add_case(
        "download table char",
        function(conn){
            result <- dbRun(conn, "table([0h,32767h,00h] as `a)")
            expect <- data.frame(
                a = c(0L, 32767L, NA_integer_)
            )
            test$assert(result, expect)
        }
    )
    test$add_case(
        "download table char empty",
        function(conn){
            result <- dbRun(conn, "table(100:0,[`a],[SHORT])")
            expect <- data.frame(
                a = integer(0)
            )
            test$assert(result, expect)
        }
    )

    # short
    test$add_case(
        "download table short",
        function(conn){
            result <- dbRun(conn, "table([0h,32767h,00h] as `a)")
            expect <- data.frame(
                a = c(0L, 32767L, NA_integer_)
            )
            test$assert(result, expect)
        }
    )
    test$add_case(
        "download table short empty",
        function(conn){
            result <- dbRun(conn, "table(100:0,[`a],[SHORT])")
            expect <- data.frame(
                a = integer(0)
            )
            test$assert(result, expect)
        }
    )

    # int
    test$add_case(
        "download table int",
        function(conn){
            result <- dbRun(conn, "table([0i,2147483647i,00i] as `a)")
            expect <- data.frame(
                a = c(0L, 2147483647L, NA_integer_)
            )
            test$assert(result, expect)
        }
    )
    test$add_case(
        "download table int empty",
        function(conn){
            result <- dbRun(conn, "table(100:0,[`a],[INT])")
            expect <- data.frame(
                a = integer(0)
            )
            test$assert(result, expect)
        }
    )

    # long
    test$add_case(
        "download table long",
        function(conn){
            result <- dbRun(conn, "table([0l,9223372036854775807l,00l] as `a)")
            expect <- data.frame(
                a = c(0, 9223372036854775807, NA_real_)
            )
            test$assert(result, expect)
        }
    )
    test$add_case(
        "download table long empty",
        function(conn){
            result <- dbRun(conn, "table(100:0,[`a],[LONG])")
            expect <- data.frame(
                a = numeric(0)
            )
            test$assert(result, expect)
        }
    )

    # date
    test$add_case(
        "download table date",
        function(conn){
            result <- dbRun(conn, "table([1970.01.01d,00d] as `a)")
            expect <- data.frame(
                a = c(as.Date("1970-01-01"), NA)
            )
            test$assert(result, expect)
        }
    )
    test$add_case(
        "download table date empty",
        function(conn){
            result <- dbRun(conn, "table(100:0,[`a],[DATE])")
            expect <- data.frame(
                a = as.Date(c())
            )
            test$assert(result, expect)
        }
    )

    # month
    test$add_case(
        "download table month",
        function(conn){
            result <- dbRun(conn, "table([1970.01M,00M] as `a)")
            expect <- data.frame(
                a = c(as.Date("1970-01-01"), NA)
            )
            test$assert(result, expect)
        }
    )
    test$add_case(
        "download table month empty",
        function(conn){
            result <- dbRun(conn, "table(100:0,[`a],[MONTH])")
            expect <- data.frame(
                a = as.Date(c())
            )
            test$assert(result, expect)
        }
    )

    # time
    test$add_case(
        "download table time",
        function(conn){
            result <- dbRun(conn, "table([13:30:10.008t,00t] as `a)")
            expect <- data.frame(
                a = c(as.POSIXct("1970-01-01 13:30:10.008", tz = "UTC"), as.POSIXct(NA, tz = "UTC"))
            )
            test$assert(result, expect)
        }
    )
    test$add_case(
        "download table time empty",
        function(conn){
            result <- dbRun(conn, "table(100:0,[`a],[TIME])")
            expect <- data.frame(
                a = as.POSIXct(c(), tz = "UTC")
            )
            test$assert(result, expect)
        }
    )

    # minute
    test$add_case(
        "download table minute",
        function(conn){
            result <- dbRun(conn, "table([13:30m,00m] as `a)")
            expect <- data.frame(
                a = c(as.POSIXct("1970-01-01 13:30:00", tz = "UTC"), as.POSIXct(NA, tz = "UTC"))
            )
            test$assert(result, expect)
        }
    )
    test$add_case(
        "download table minute empty",
        function(conn){
            result <- dbRun(conn, "table(100:0,[`a],[MINUTE])")
            expect <- data.frame(
                a = as.POSIXct(c(), tz = "UTC")
            )
            test$assert(result, expect)
        }
    )

    # second
    test$add_case(
        "download table second",
        function(conn){
            result <- dbRun(conn, "table([13:30:10s,00s] as `a)")
            expect <- data.frame(
                a = c(as.POSIXct("1970-01-01 13:30:10", tz = "UTC"), as.POSIXct(NA, tz = "UTC"))
            )
            test$assert(result, expect)
        }
    )
    test$add_case(
        "download table second empty",
        function(conn){
            result <- dbRun(conn, "table(100:0,[`a],[SECOND])")
            expect <- data.frame(
                a = as.POSIXct(c(), tz = "UTC")
            )
            test$assert(result, expect)
        }
    )

    # datetime
    test$add_case(
        "download table datetime",
        function(conn){
            result <- dbRun(conn, "table([2012.06.13T13:30:10D,00D] as `a)")
            expect <- data.frame(
                a = c(as.POSIXct("2012-06-13 13:30:10", tz = "UTC"), as.POSIXct(NA, tz = "UTC"))
            )
            test$assert(result, expect)
        }
    )
    test$add_case(
        "download table datetime empty",
        function(conn){
            result <- dbRun(conn, "table(100:0,[`a],[DATETIME])")
            expect <- data.frame(
                a = as.POSIXct(c(), tz = "UTC")
            )
            test$assert(result, expect)
        }
    )

    # timestamp
    test$add_case(
        "download table timestamp",
        function(conn){
            result <- dbRun(conn, "table([2012.06.13T13:30:10.008T,00T] as `a)")
            expect <- data.frame(
                a = c(as.POSIXct("2012-06-13 13:30:10.008", tz = "UTC"), as.POSIXct(NA, tz = "UTC"))
            )
            test$assert(result, expect)
        }
    )
    test$add_case(
        "download table timestamp empty",
        function(conn){
            result <- dbRun(conn, "table(100:0,[`a],[TIMESTAMP])")
            expect <- data.frame(
                a = as.POSIXct(c(), tz = "UTC")
            )
            test$assert(result, expect)
        }
    )

    # nanotime
    test$add_case(
        "download table nanotime",
        function(conn){
            result <- dbRun(conn, "table([13:30:10.008007006n,00n] as `a)")
            expect <- data.frame(
                a = c(as.POSIXct("1970-01-01 13:30:10.008007006", tz = "UTC"), as.POSIXct(NA, tz = "UTC"))
            )
            test$assert(result, expect)
        }
    )
    test$add_case(
        "download table nanotime empty",
        function(conn){
            result <- dbRun(conn, "table(100:0,[`a],[NANOTIME])")
            expect <- data.frame(
                a = as.POSIXct(c(), tz = "UTC")
            )
            test$assert(result, expect)
        }
    )

    # nanotimestamp
    test$add_case(
        "download table nanotimestamp",
        function(conn){
            result <- dbRun(conn, "table([2012.06.13T13:30:10.008007006N,00N] as `a)")
            expect <- data.frame(
                a = c(as.POSIXct("2012-06-13 13:30:10.008007006", tz = "UTC"), as.POSIXct(NA, tz = "UTC"))
            )
            test$assert(result, expect)
        }
    )
    test$add_case(
        "download table nanotimestamp empty",
        function(conn){
            result <- dbRun(conn, "table(100:0,[`a],[NANOTIMESTAMP])")
            expect <- data.frame(
                a = as.POSIXct(c(), tz = "UTC")
            )
            test$assert(result, expect)
        }
    )

    # float
    test$add_case(
        "download table float",
        function(conn){
            result <- dbRun(conn, "table([0.0f,float('nan'),float('inf'),00f] as `a)")
            expect <- data.frame(
                a = c(0, NaN, Inf, NA_real_)
            )
            test$assert(result, expect)
        }
    )
    test$add_case(
        "download table float empty",
        function(conn){
            result <- dbRun(conn, "table(100:0,[`a],[FLOAT])")
            expect <- data.frame(
                a = numeric(0)
            )
            test$assert(result, expect)
        }
    )

    # double
    test$add_case(
        "download table double",
        function(conn){
            result <- dbRun(conn, "table([0.0F,00F] as `a)")
            expect <- data.frame(
                a = c(0, NA_real_)
            )
            test$assert(result, expect)
        }
    )
    test$add_case(
        "download table double empty",
        function(conn){
            result <- dbRun(conn, "table(100:0,[`a],[DOUBLE])")
            expect <- data.frame(
                a = numeric(0)
            )
            test$assert(result, expect)
        }
    )

    # string
    test$add_case(
        "download table string",
        function(conn){
            result <- dbRun(conn, "table([`a,\"\"] as `a)")
            expect <- data.frame(
                a = c("a", NA_character_)
            )
            test$assert(result, expect)
        }
    )
    test$add_case(
        "download table string empty",
        function(conn){
            result <- dbRun(conn, "table(100:0,[`a],[STRING])")
            expect <- data.frame(
                a = character(0)
            )
            test$assert(result, expect)
        }
    )

    # symbol
    test$add_case(
        "download table symbol",
        function(conn){
            result <- dbRun(conn, "table(symbol([`a,`a,`a,`a,`a,`a,`a,`a,`a,`a,\"\"]) as `a)")
            expect <- data.frame(
                a = factor(c("a", "a", "a", "a", "a", "a", "a", "a", "a", "a", NA_character_), levels = c(NA_character_, "a"), exclude = NULL)
            )
            test$assert(result, expect)
        }
    )
    test$add_case(
        "download table symbol empty",
        function(conn){
            result <- dbRun(conn, "table(100:0,[`a],[SYMBOL])")
            expect <- data.frame(
                a = character(0)
            )
            test$assert(result, expect)
        }
    )
}