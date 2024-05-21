if (!exists("TESTRUNSCALAR_R__", envir = .GlobalEnv)){
    TESTRUNSCALAR_R__ <- NULL
    source("pub/Test.R")

    # void
    test$add_case(
        "download scalar void",
        function(conn){
            result <- dbRun(conn, "NULL")
            test$assert(result, NA)
        }
    )

    # bool
    test$add_case(
        "download scalar bool true",
        function(conn){
            result <- dbRun(conn, "true")
            test$assert(result, TRUE)
        }
    )
    test$add_case(
        "download scalar bool false",
        function(conn){
            result <- dbRun(conn, "false")
            test$assert(result, FALSE)
        }
    )
    test$add_case(
        "download scalar bool 00b",
        function(conn){
            result <- dbRun(conn, "00b")
            test$assert(result, NA)
        }
    )

    # char
    test$add_case(
        "download scalar char 0c",
        function(conn){
            result <- dbRun(conn, "0c")
            test$assert(result, 0L)
        }
    )
    test$add_case(
        "download scalar char 127c",
        function(conn){
            result <- dbRun(conn, "127c")
            test$assert(result, 127L)
        }
    )
    test$add_case(
        "download scalar char -127c",
        function(conn){
            result <- dbRun(conn, "-127c")
            test$assert(result, -127L)
        }
    )
    test$add_case(
        "download scalar char 00c",
        function(conn){
            result <- dbRun(conn, "00c")
            test$assert(result, NA_integer_)
        }
    )

    # short
    test$add_case(
        "download scalar short 0h",
        function(conn){
            result <- dbRun(conn, "0h")
            test$assert(result, 0L)
        }
    )
    test$add_case(
        "download scalar short 32767h",
        function(conn){
            result <- dbRun(conn, "32767h")
            test$assert(result, 32767L)
        }
    )
    test$add_case(
        "download scalar short -32767h",
        function(conn){
            result <- dbRun(conn, "-32767h")
            test$assert(result, -32767L)
        }
    )
    test$add_case(
        "download scalar short 00h",
        function(conn){
            result <- dbRun(conn, "00h")
            test$assert(result, NA_integer_)
        }
    )

    # int
    test$add_case(
        "download scalar int 0i",
        function(conn){
            result <- dbRun(conn, "0i")
            test$assert(result, 0L)
        }
    )
    test$add_case(
        "download scalar int 2147483647i",
        function(conn){
            result <- dbRun(conn, "2147483647i")
            test$assert(result, 2147483647L)
        }
    )
    test$add_case(
        "download scalar int -2147483647i",
        function(conn){
            result <- dbRun(conn, "-2147483647i")
            test$assert(result, -2147483647L)
        }
    )
    test$add_case(
        "download scalar int 00i",
        function(conn){
            result <- dbRun(conn, "00i")
            test$assert(result, NA_integer_)
        }
    )

    # long
    test$add_case(
        "download scalar long 0l",
        function(conn){
            result <- dbRun(conn, "0l")
            test$assert(result, 0)
        }
    )
    test$add_case(
        "download scalar long 9223372036854775807l",
        function(conn){
            result <- dbRun(conn, "9223372036854775807l")
            test$assert(result, 9223372036854775807)
        }
    )
    test$add_case(
        "download scalar long -9223372036854775807l",
        function(conn){
            result <- dbRun(conn, "-9223372036854775807l")
            test$assert(result, -9223372036854775807)
        }
    )
    test$add_case(
        "download scalar long 00l",
        function(conn){
            result <- dbRun(conn, "00l")
            test$assert(result, NA_real_)
        }
    )

    # date
    test$add_case(
        "download scalar date 1970.01.01d",
        function(conn){
            result <- dbRun(conn, "1970.01.01d")
            test$assert(result, as.Date("1970-01-01"))
        }
    )
    test$add_case(
        "download scalar date 00d",
        function(conn){
            result <- dbRun(conn, "00d")
            test$assert(result, as.Date(NA))
        }
    )

    # month
    test$add_case(
        "download scalar month 1970.01M",
        function(conn){
            result <- dbRun(conn, "1970.01M")
            test$assert(result, as.Date("1970-01-01"))
        }
    )
    test$add_case(
        "download scalar month 00M",
        function(conn){
            result <- dbRun(conn, "00M")
            test$assert(result, as.Date(NA))
        }
    )

    # time
    test$add_case(
        "download scalar time 13:30:10.008t",
        function(conn){
            result <- dbRun(conn, "13:30:10.008t")
            test$assert(result, as.POSIXct("1970-01-01 13:30:10.008", tz = "UTC"))
        }
    )
    test$add_case(
        "download scalar time 00t",
        function(conn){
            result <- dbRun(conn, "00t")
            test$assert(result, as.POSIXct(NA))
        }
    )

    # minute
    test$add_case(
        "download scalar minute 13:30m",
        function(conn){
            result <- dbRun(conn, "13:30m")
            test$assert(result, as.POSIXct("1970-01-01 13:30:00", tz = "UTC"))
        }
    )
    test$add_case(
        "download scalar minute 00m",
        function(conn){
            result <- dbRun(conn, "00m")
            test$assert(result, as.POSIXct(NA))
        }
    )

    # minute
    test$add_case(
        "download scalar minute 13:30m",
        function(conn){
            result <- dbRun(conn, "13:30m")
            test$assert(result, as.POSIXct("1970-01-01 13:30:00", tz = "UTC"))
        }
    )
    test$add_case(
        "download scalar minute 00m",
        function(conn){
            result <- dbRun(conn, "00m")
            test$assert(result, as.POSIXct(NA))
        }
    )

    # second
    test$add_case(
        "download scalar second 13:30:10s",
        function(conn){
            result <- dbRun(conn, "13:30:10s")
            test$assert(result, as.POSIXct("1970-01-01 13:30:10", tz = "UTC"))
        }
    )
    test$add_case(
        "download scalar second 00s",
        function(conn){
            result <- dbRun(conn, "00s")
            test$assert(result, as.POSIXct(NA))
        }
    )

    # datetime
    test$add_case(
        "download scalar datetime 2012.06.13T13:30:10D",
        function(conn){
            result <- dbRun(conn, "2012.06.13T13:30:10D")
            test$assert(result, as.POSIXct("2012-06-13 13:30:10", tz = "UTC"))
        }
    )
    test$add_case(
        "download scalar datetime 00D",
        function(conn){
            result <- dbRun(conn, "00D")
            test$assert(result, as.POSIXct(NA))
        }
    )

    # timestamp
    test$add_case(
        "download scalar timestamp 2012.06.13T13:30:10.008T",
        function(conn){
            result <- dbRun(conn, "2012.06.13T13:30:10.008T")
            test$assert(result, as.POSIXct("2012-06-13 13:30:10.008", tz = "UTC"))
        }
    )
    test$add_case(
        "download scalar timestamp 00T",
        function(conn){
            result <- dbRun(conn, "00T")
            test$assert(result, as.POSIXct(NA))
        }
    )

    # nanotime
    test$add_case(
        "download scalar nanotime 13:30:10.008007006n",
        function(conn){
            result <- dbRun(conn, "13:30:10.008007006n")
            test$assert(result, as.POSIXct("1970-01-01 13:30:10.008007006", tz = "UTC"))
        }
    )
    test$add_case(
        "download scalar nanotime 00n",
        function(conn){
            result <- dbRun(conn, "00n")
            test$assert(result, as.POSIXct(NA))
        }
    )

    # nanotimestamp
    test$add_case(
        "download scalar nanotimestamp 2012.06.13T13:30:10.008007006N",
        function(conn){
            result <- dbRun(conn, "2012.06.13T13:30:10.008007006N")
            test$assert(result, as.POSIXct("2012-06-13 13:30:10.008007006", tz = "UTC"))
        }
    )
    test$add_case(
        "download scalar nanotimestamp 00N",
        function(conn){
            result <- dbRun(conn, "00N")
            test$assert(result, as.POSIXct(NA))
        }
    )

    # float
    test$add_case(
        "download scalar float 0.0f",
        function(conn){
            result <- dbRun(conn, "0.0f")
            test$assert(result, 0)
        }
    )
    test$add_case(
        "download scalar float float('nan')",
        function(conn){
            result <- dbRun(conn, "float('nan')")
            test$assert(result, NaN)
        }
    )
    test$add_case(
        "download pair float 0.0f:float('inf')",
        function(conn){
            result <- dbRun(conn, "0.0f:float('inf')")
            test$assert(result, c(0, Inf))
        }
    )
    test$add_case(
        "download scalar float 00f",
        function(conn){
            result <- dbRun(conn, "00f")
            test$assert(result, NA_real_)
        }
    )

    # double
    test$add_case(
        "download scalar double 0.0F",
        function(conn){
            result <- dbRun(conn, "0.0F")
            test$assert(result, 0)
        }
    )
    test$add_case(
        "download scalar double pi",
        function(conn){
            result <- dbRun(conn, "pi")
            test$assert(result, pi)
        }
    )
    test$add_case(
        "download scalar double 00F",
        function(conn){
            result <- dbRun(conn, "00F")
            test$assert(result, NA_real_)
        }
    )

    # string
    test$add_case(
        "download scalar string 'abc!@#中文 123'",
        function(conn){
            result <- dbRun(conn, "'abc!@#中文 123'")
            test$assert(result, "abc!@#中文 123")
        }
    )
    test$add_case(
        "download scalar string \"\"",
        function(conn){
            result <- dbRun(conn, "\"\"")
            test$assert(result, NA_character_)
        }
    )
}