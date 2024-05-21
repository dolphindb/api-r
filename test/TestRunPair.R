if (!exists("TESTRUNPAIR_R__", envir = .GlobalEnv)){
    TESTRUNPAIR_R__ <- NULL
    source("pub/Test.R")

    library(RDolphinDB)

    # bool
    test$add_case(
        "download pair bool true:false",
        function(conn){
            result <- dbRun(conn, "true:false")
            test$assert(result, c(TRUE, FALSE))
        }
    )
    test$add_case(
        "download pair bool true:00b",
        function(conn){
            result <- dbRun(conn, "true:00b")
            test$assert(result, c(TRUE, NA))
        }
    )

    # char
    test$add_case(
        "download pair char 0c:127c",
        function(conn){
            result <- dbRun(conn, "0c:127c")
            test$assert(result, c(0L, 127L))
        }
    )
    test$add_case(
        "download pair char 0c:00c",
        function(conn){
            result <- dbRun(conn, "0c:00c")
            test$assert(result, c(0L, NA_integer_))
        }
    )

    # short
    test$add_case(
        "download pair short 0h:32767h",
        function(conn){
            result <- dbRun(conn, "0h:32767h")
            test$assert(result, c(0L, 32767L))
        }
    )
    test$add_case(
        "download pair short 0h:00h",
        function(conn){
            result <- dbRun(conn, "0h:00h")
            test$assert(result, c(0L, NA_integer_))
        }
    )

    # int
    test$add_case(
        "download pair int 0i:2147483647i",
        function(conn){
            result <- dbRun(conn, "0i:2147483647i")
            test$assert(result, c(0L, 2147483647L))
        }
    )
    test$add_case(
        "download pair int 0i:00i",
        function(conn){
            result <- dbRun(conn, "0i:00i")
            test$assert(result, c(0L, NA_integer_))
        }
    )

    # long
    test$add_case(
        "download pair long 0l:9223372036854775807l",
        function(conn){
            result <- dbRun(conn, "0l:9223372036854775807l")
            test$assert(result, c(0L, 9223372036854775807))
        }
    )
    test$add_case(
        "download pair long 0l:00l",
        function(conn){
            result <- dbRun(conn, "0l:00l")
            test$assert(result, c(0, NA_real_))
        }
    )

    # date
    test$add_case(
        "download pair date 1970.01.01d:1970.01.02d",
        function(conn){
            result <- dbRun(conn, "1970.01.01d:1970.01.02d")
            test$assert(result, c(as.Date("1970-01-01"), as.Date("1970-01-02")))
        }
    )
    test$add_case(
        "download pair date 1970.01.01d:00d",
        function(conn){
            result <- dbRun(conn, "1970.01.01d:00d")
            test$assert(result, c(as.Date("1970-01-01"), NA))
        }
    )

    # month
    test$add_case(
        "download pair month 1970.01M:1970.02M",
        function(conn){
            result <- dbRun(conn, "1970.01M:1970.02M")
            test$assert(result, c(as.Date("1970-01-01"), as.Date("1970-02-01")))
        }
    )
    test$add_case(
        "download pair month 1970.01M:00M",
        function(conn){
            result <- dbRun(conn, "1970.01M:00M")
            test$assert(result, c(as.Date("1970-01-01"), NA))
        }
    )

    # time
    test$add_case(
        "download pair time 13:30:10.008t : 13:30:10.008t",
        function(conn){
            result <- dbRun(conn, "13:30:10.008t : 13:30:10.008t")
            test$assert(result, c(as.POSIXct("1970-01-01 13:30:10.008", tz = "UTC"), as.POSIXct("1970-01-01 13:30:10.008", tz = "UTC")))
        }
    )
    test$add_case(
        "download pair time 13:30:10.008t : 00t",
        function(conn){
            result <- dbRun(conn, "13:30:10.008t : 00t")
            test$assert(result, c(as.POSIXct("1970-01-01 13:30:10.008", tz = "UTC"), as.POSIXct(NA, tz = "UTC")))
        }
    )

    # minute
    test$add_case(
        "download pair minute 13:30m : 13:30m",
        function(conn){
            result <- dbRun(conn, "13:30m : 13:30m")
            test$assert(result, c(as.POSIXct("1970-01-01 13:30:00", tz = "UTC"), as.POSIXct("1970-01-01 13:30:00", tz = "UTC")))
        }
    )
    test$add_case(
        "download pair minute 13:30m : 00m",
        function(conn){
            result <- dbRun(conn, "13:30m : 00m")
            test$assert(result, c(as.POSIXct("1970-01-01 13:30:00", tz = "UTC"), as.POSIXct(NA, tz = "UTC")))
        }
    )

    # second
    test$add_case(
        "download pair second 13:30:10s : 13:30:11s",
        function(conn){
            result <- dbRun(conn, "13:30:10s : 13:30:11s")
            test$assert(result, c(as.POSIXct("1970-01-01 13:30:10", tz = "UTC"), as.POSIXct("1970-01-01 13:30:11", tz = "UTC")))
        }
    )
    test$add_case(
        "download pair second 13:30:10s : 00s",
        function(conn){
            result <- dbRun(conn, "13:30:10s : 00s")
            test$assert(result, c(as.POSIXct("1970-01-01 13:30:10", tz = "UTC"), as.POSIXct(NA, tz = "UTC")))
        }
    )

    # datetime
    test$add_case(
        "download pair datetime 2012.06.13T13:30:10D : 2012.06.13T13:30:11D",
        function(conn){
            result <- dbRun(conn, "2012.06.13T13:30:10D : 2012.06.13T13:30:11D")
            test$assert(result, c(as.POSIXct("2012-06-13 13:30:10", tz = "UTC"), as.POSIXct("2012-06-13 13:30:11", tz = "UTC")))
        }
    )
    test$add_case(
        "download pair datetime 2012.06.13T13:30:10D : 00D",
        function(conn){
            result <- dbRun(conn, "2012.06.13T13:30:10D : 00D")
            test$assert(result, c(as.POSIXct("2012-06-13 13:30:10", tz = "UTC"), as.POSIXct(NA, tz = "UTC")))
        }
    )

    # timestamp
    test$add_case(
        "download pair timestamp 2012.06.13T13:30:10.008T : 2012.06.13T13:30:10.009T",
        function(conn){
            result <- dbRun(conn, "2012.06.13T13:30:10.008T : 2012.06.13T13:30:10.009T")
            test$assert(result, c(as.POSIXct("2012-06-13 13:30:10.008", tz = "UTC"), as.POSIXct("2012-06-13 13:30:10.009", tz = "UTC")))
        }
    )
    test$add_case(
        "download pair timestamp 2012.06.13T13:30:10.008T : 00T",
        function(conn){
            result <- dbRun(conn, "2012.06.13T13:30:10.008T : 00T")
            test$assert(result, c(as.POSIXct("2012-06-13 13:30:10.008", tz = "UTC"), as.POSIXct(NA, tz = "UTC")))
        }
    )

    # nanotime
    test$add_case(
        "download pair nanotime 13:30:10.008007006n : 13:30:10.008007007n",
        function(conn){
            result <- dbRun(conn, "13:30:10.008007006n : 13:30:10.008007007n")
            test$assert(result, c(as.POSIXct("1970-01-01 13:30:10.008007006", tz = "UTC"), as.POSIXct("1970-01-01 13:30:10.008007007", tz = "UTC")))
        }
    )
    test$add_case(
        "download pair nanotime 13:30:10.008007006n : 00n",
        function(conn){
            result <- dbRun(conn, "13:30:10.008007006n : 00n")
            test$assert(result, c(as.POSIXct("1970-01-01 13:30:10.008007006", tz = "UTC"), as.POSIXct(NA, tz = "UTC")))
        }
    )

    # nanotimestamp
    test$add_case(
        "download pair nanotimestamp 2012.06.13T13:30:10.008007006N : 2012.06.13T13:30:10.008007007N",
        function(conn){
            result <- dbRun(conn, "2012.06.13T13:30:10.008007006N : 2012.06.13T13:30:10.008007007N")
            test$assert(result, c(as.POSIXct("2012-06-13 13:30:10.008007006", tz = "UTC"), as.POSIXct("2012-06-13 13:30:10.008007007", tz = "UTC")))
        }
    )
    test$add_case(
        "download pair nanotimestamp 2012.06.13T13:30:10.008007006N : 00N",
        function(conn){
            result <- dbRun(conn, "2012.06.13T13:30:10.008007006N : 00N")
            test$assert(result, c(as.POSIXct("2012-06-13 13:30:10.008007006", tz = "UTC"), as.POSIXct(NA, tz = "UTC")))
        }
    )

    # float
    test$add_case(
        "download pair float 0.0f:0.1f",
        function(conn){
            result <- dbRun(conn, "0.0f:0.1f")
            test$assert(result, c(0, 0.1))
        }
    )
    test$add_case(
        "download pair float 0.0f:float('nan')",
        function(conn){
            result <- dbRun(conn, "0.0f:float('nan')")
            test$assert(result, c(0, NaN))
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
        "download pair float 0.0f:00f",
        function(conn){
            result <- dbRun(conn, "0.0f:00f")
            test$assert(result, c(0, NA_real_))
        }
    )

    # double
    test$add_case(
        "download pair double 0.0F:0.1F",
        function(conn){
            result <- dbRun(conn, "0.0F:0.1F")
            test$assert(result, c(0, 0.1))
        }
    )
    test$add_case(
        "download pair double 0.0F:00F",
        function(conn){
            result <- dbRun(conn, "0.0F:00F")
            test$assert(result, c(0, NA_real_))
        }
    )

    # string
    test$add_case(
        "download pair string `a:`b",
        function(conn){
            result <- dbRun(conn, "`a:`b")
            test$assert(result, c("a", "b"))
        }
    )
    test$add_case(
        "download pair string `a:\"\"",
        function(conn){
            result <- dbRun(conn, "`a:\"\"")
            test$assert(result, c("a", NA_character_))
        }
    )
}