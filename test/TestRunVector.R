if (!exists("TESTRUNVECTOR_R__", envir = .GlobalEnv)){
    TESTRUNVECTOR_R__ <- NULL
    source("pub/Test.R")

    library(RDolphinDB)

    # bool
    test$add_case(
        "download vector bool [true,false,00b]",
        function(conn){
            result <- dbRun(conn, "[true,false,00b]")
            test$assert(result, c(TRUE, FALSE, NA))
        }
    )
    test$add_case(
        "download vector bool array(BOOL)",
        function(conn){
            result <- dbRun(conn, "array(BOOL)")
            test$assert(result, logical(0))
        }
    )

    # char
    test$add_case(
        "download vector char [0c,127c,00c]",
        function(conn){
            result <- dbRun(conn, "[0c,127c,00c]")
            test$assert(result, c(0L, 127L, NA_integer_))
        }
    )
    test$add_case(
        "download vector char array(CHAR)",
        function(conn){
            result <- dbRun(conn, "array(CHAR)")
            test$assert(result, integer(0))
        }
    )

    # short
    test$add_case(
        "download vector short [0h,32767h,00h]",
        function(conn){
            result <- dbRun(conn, "[0h,32767h,00h]")
            test$assert(result, c(0L, 32767L, NA_integer_))
        }
    )
    test$add_case(
        "download vector short array(SHORT)",
        function(conn){
            result <- dbRun(conn, "array(SHORT)")
            test$assert(result, integer(0))
        }
    )

    # int
    test$add_case(
        "download vector int [0i,2147483647i,00i]",
        function(conn){
            result <- dbRun(conn, "[0i,2147483647i,00i]")
            test$assert(result, c(0L, 2147483647L, NA_integer_))
        }
    )
    test$add_case(
        "download vector int array(INT)",
        function(conn){
            result <- dbRun(conn, "array(INT)")
            test$assert(result, integer(0))
        }
    )

    # long
    test$add_case(
        "download vector long [0l,9223372036854775807l,00l]",
        function(conn){
            result <- dbRun(conn, "[0l,9223372036854775807l,00l]")
            test$assert(result, c(0, 9223372036854775807, NA_real_))
        }
    )
    test$add_case(
        "download vector long array(LONG)",
        function(conn){
            result <- dbRun(conn, "array(LONG)")
            test$assert(result, numeric(0))
        }
    )

    # date
    test$add_case(
        "download vector date [1970.01.01d,00d]",
        function(conn){
            result <- dbRun(conn, "[1970.01.01d,00d]")
            test$assert(result, c(as.Date("1970-01-01"), NA))
        }
    )
    test$add_case(
        "download vector date array(DATE)",
        function(conn){
            result <- dbRun(conn, "array(DATE)")
            test$assert(result, as.Date(c()))
        }
    )

    # month
    test$add_case(
        "download vector month [1970.01M,00M]",
        function(conn){
            result <- dbRun(conn, "[1970.01M,00M]")
            test$assert(result, c(as.Date("1970-01-01"), NA))
        }
    )
    test$add_case(
        "download vector month array(MONTH)",
        function(conn){
            result <- dbRun(conn, "array(MONTH)")
            test$assert(result, as.Date(c()))
        }
    )

    # time
    test$add_case(
        "download vector time [13:30:10.008t,00t]",
        function(conn){
            result <- dbRun(conn, "[13:30:10.008t,00t]")
            test$assert(result, c(as.POSIXct("1970-01-01 13:30:10.008", tz = "UTC"), as.POSIXct(NA, tz = "UTC")))
        }
    )
    test$add_case(
        "download vector time array(TIME)",
        function(conn){
            result <- dbRun(conn, "array(TIME)")
            test$assert(result, as.POSIXct(c(), tz = "UTC"))
        }
    )

    # minute
    test$add_case(
        "download vector minute [13:30m,00m]",
        function(conn){
            result <- dbRun(conn, "[13:30m,00m]")
            test$assert(result, c(as.POSIXct("1970-01-01 13:30:00", tz = "UTC"), as.POSIXct(NA, tz = "UTC")))
        }
    )
    test$add_case(
        "download vector minute array(MINUTE)",
        function(conn){
            result <- dbRun(conn, "array(MINUTE)")
            test$assert(result, as.POSIXct(c(), tz = "UTC"))
        }
    )

    # second
    test$add_case(
        "download vector second [13:30:10s,00s]",
        function(conn){
            result <- dbRun(conn, "[13:30:10s,00s]")
            test$assert(result, c(as.POSIXct("1970-01-01 13:30:10", tz = "UTC"), as.POSIXct(NA, tz = "UTC")))
        }
    )
    test$add_case(
        "download vector second array(SECOND)",
        function(conn){
            result <- dbRun(conn, "array(SECOND)")
            test$assert(result, as.POSIXct(c(), tz = "UTC"))
        }
    )

    # datetime
    test$add_case(
        "download vector datetime [2012.06.13T13:30:10D,00D]",
        function(conn){
            result <- dbRun(conn, "[2012.06.13T13:30:10D,00D]")
            test$assert(result, c(as.POSIXct("2012-06-13 13:30:10", tz = "UTC"), as.POSIXct(NA, tz = "UTC")))
        }
    )
    test$add_case(
        "download vector datetime array(DATETIME)",
        function(conn){
            result <- dbRun(conn, "array(DATETIME)")
            test$assert(result, as.POSIXct(c(), tz = "UTC"))
        }
    )

    # timestamp
    test$add_case(
        "download vector timestamp [2012.06.13T13:30:10.008T,00T]",
        function(conn){
            result <- dbRun(conn, "[2012.06.13T13:30:10.008T,00T]")
            test$assert(result, c(as.POSIXct("2012-06-13 13:30:10.008", tz = "UTC"), as.POSIXct(NA, tz = "UTC")))
        }
    )
    test$add_case(
        "download vector timestamp array(TIMESTAMP)",
        function(conn){
            result <- dbRun(conn, "array(TIMESTAMP)")
            test$assert(result, as.POSIXct(c(), tz = "UTC"))
        }
    )

    # nanotime
    test$add_case(
        "download vector nanotime [13:30:10.008007006n,00n]",
        function(conn){
            result <- dbRun(conn, "[13:30:10.008007006n,00n]")
            test$assert(result, c(as.POSIXct("1970-01-01 13:30:10.008007006", tz = "UTC"), as.POSIXct(NA, tz = "UTC")))
        }
    )
    test$add_case(
        "download vector nanotime array(NANOTIME)",
        function(conn){
            result <- dbRun(conn, "array(NANOTIME)")
            test$assert(result, as.POSIXct(c(), tz = "UTC"))
        }
    )

    # nanotimestamp
    test$add_case(
        "download vector nanotimestamp [2012.06.13T13:30:10.008007006N,00N]",
        function(conn){
            result <- dbRun(conn, "[2012.06.13T13:30:10.008007006N,00N]")
            test$assert(result, c(as.POSIXct("2012-06-13 13:30:10.008007006", tz = "UTC"), as.POSIXct(NA, tz = "UTC")))
        }
    )
    test$add_case(
        "download vector nanotimestamp array(NANOTIMESTAMP)",
        function(conn){
            result <- dbRun(conn, "array(NANOTIMESTAMP)")
            test$assert(result, as.POSIXct(c(), tz = "UTC"))
        }
    )

    # float
    test$add_case(
        "download vector float [0.0f,float('nan'),float('inf'),00f]",
        function(conn){
            result <- dbRun(conn, "[0.0f,float('nan'),float('inf'),00f]")
            test$assert(result, c(0, NaN, Inf, NA_real_))
        }
    )
    test$add_case(
        "download vector float array(FLOAT)",
        function(conn){
            result <- dbRun(conn, "array(FLOAT)")
            test$assert(result, numeric(0))
        }
    )

    # double
    test$add_case(
        "download vector double [0.0F,00F]",
        function(conn){
            result <- dbRun(conn, "[0.0F,00F]")
            test$assert(result, c(0, NA_real_))
        }
    )
    test$add_case(
        "download vector double array(DOUBLE)",
        function(conn){
            result <- dbRun(conn, "array(DOUBLE)")
            test$assert(result, numeric(0))
        }
    )

    # string
    test$add_case(
        "download vector string [`a,\"\"]",
        function(conn){
            result <- dbRun(conn, "[`a,\"\"]")
            test$assert(result, c("a", NA_character_))
        }
    )
    test$add_case(
        "download vector string array(STRING)",
        function(conn){
            result <- dbRun(conn, "array(STRING)")
            test$assert(result, character(0))
        }
    )

    # symbol
    test$add_case(
        "download vector symbol symbol([`a,`a,`a,`a,`a,`a,`a,`a,`a,`a,\"\"])",
        function(conn){
            result <- dbRun(conn, "symbol([`a,`a,`a,`a,`a,`a,`a,`a,`a,`a,\"\"])")
            test$assert(result, factor(c("a", "a", "a", "a", "a", "a", "a", "a", "a", "a", NA_character_), levels = c(NA_character_, "a"), exclude = NULL))
        }
    )
    test$add_case(
        "download vector symbol array(SYMBOL)",
        function(conn){
            result <- dbRun(conn, "array(SYMBOL)")
            test$assert(result, character(0))
        }
    )

    # any empty
    test$add_case(
        "download vector any empty",
        function(conn){
            result <- dbRun(conn, "array(ANY)")
            test$assert(result, list())
        }
    )

    # any vector
    test$add_case(
        "download vector any vector",
        function(conn){
            result <- dbRun(conn, "x=array(ANY).append!(true).append!(0c).append!(0h).append!(0i);x")
            test$assert(result, list(TRUE, 0L, 0L, 0L))
        }
    )

    # vector of pair
    test$add_case(
        "download vector vector of pair",
        function(conn){
            result <- dbRun(conn, "[1:2]")
            test$assert(result, list(c(1L, 2L)))
        }
    )

    # vector of vector
    test$add_case(
        "download vector vector of vector",
        function(conn){
            result <- dbRun(conn, "[[1,2]]")
            test$assert(result, list(c(1L, 2L)))
        }
    )

    # vector of symbol
    test$add_case(
        "download vector vector of symbol",
        function(conn){
            result <- dbRun(conn, "x=array(ANY).append!(symbol([`a,`a,`a,`a,`a,`a,`a,`a,`a,`a,\"\"]));x")
            test$assert(result, list(factor(c("a", "a", "a", "a", "a", "a", "a", "a", "a", "a", NA_character_), levels = c(NA_character_, "a"), exclude = NULL)))
        }
    )

    # vector of matrix
    test$add_case(
        "download vector vector of matrix",
        function(conn){
            result <- dbRun(conn, "x=matrix([true,false,00b],[true,false,00b]);x.rename!(`row1`row2`row3,`col1`col2);[x]")
            expect <- matrix(c(TRUE, FALSE, NA, TRUE, FALSE, NA), nrow = 3, byrow = FALSE)
            colnames(expect) <- c("col1", "col2")
            rownames(expect) <- c("row1", "row2", "row3")
            test$assert(result, list(expect))
        }
    )

    # vector of set
    test$add_case(
        "download vector vector of set",
        function(conn){
            result <- dbRun(conn, "[set([1,2])]")
            test$assert(result, list(c(2L, 1L)))
        }
    )

    # vector of table
    test$add_case(
        "download vector vector of table",
        function(conn){
            result <- dbRun(conn, "[table([1] as `a)]")
            expect <- data.frame(
                a = c(1)
            )
            test$assert(result, list(expect))
        }
    )

    # vector of symbol table
    test$add_case(
        "download vector vector of symbol table",
        function(conn){
            result <- dbRun(conn, "[table(symbol([`a,`a,`a,`a,`a,`a,`a,`a,`a,`a,\"\"]) as `a)]")
            expect <- data.frame(
                a = factor(c("a", "a", "a", "a", "a", "a", "a", "a", "a", "a", NA_character_), levels = c(NA_character_, "a"), exclude = NULL)
            )
            test$assert(result, list(expect))
        }
    )
}