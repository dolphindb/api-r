if (!exists("TESTRUNMATRIX_R__", envir = .GlobalEnv)){
    TESTRUNMATRIX_R__ <- NULL
    source("pub/Test.R")

    library(RDolphinDB)

    # bool
    test$add_case(
        "download matrix bool",
        function(conn){
            result <- dbRun(conn, "x=matrix([true,false,00b],[true,false,00b]);x.rename!(`row1`row2`row3,`col1`col2);x")
            expect <- matrix(c(TRUE, FALSE, NA, TRUE, FALSE, NA), nrow = 3, byrow = FALSE)
            colnames(expect) <- c("col1", "col2")
            rownames(expect) <- c("row1", "row2", "row3")
            test$assert(result, expect)
        }
    )

    # char
    test$add_case(
        "download matrix char",
        function(conn){
            result <- dbRun(conn, "x=matrix([0c,127c,00c],[0c,127c,00c]);x.rename!(`row1`row2`row3,`col1`col2);x")
            expect <- matrix(c(0L, 127L, NA_integer_, 0L, 127L, NA_integer_), nrow = 3, byrow = FALSE)
            colnames(expect) <- c("col1", "col2")
            rownames(expect) <- c("row1", "row2", "row3")
            test$assert(result, expect)
        }
    )

    # short
    test$add_case(
        "download matrix short",
        function(conn){
            result <- dbRun(conn, "x=matrix([0h,32767h,00h],[0h,32767h,00h]);x.rename!(`row1`row2`row3,`col1`col2);x")
            expect <- matrix(c(0L, 32767L, NA_integer_, 0L, 32767L, NA_integer_), nrow = 3, byrow = FALSE)
            colnames(expect) <- c("col1", "col2")
            rownames(expect) <- c("row1", "row2", "row3")
            test$assert(result, expect)
        }
    )

    # int
    test$add_case(
        "download matrix int",
        function(conn){
            result <- dbRun(conn, "x=matrix([0i,2147483647i,00i],[0i,2147483647i,00i]);x.rename!(`row1`row2`row3,`col1`col2);x")
            expect <- matrix(c(0L, 2147483647L, NA_integer_, 0L, 2147483647L, NA_integer_), nrow = 3, byrow = FALSE)
            colnames(expect) <- c("col1", "col2")
            rownames(expect) <- c("row1", "row2", "row3")
            test$assert(result, expect)
        }
    )

    # long
    test$add_case(
        "download matrix long",
        function(conn){
            result <- dbRun(conn, "x=matrix([0l,9223372036854775807l,00l],[0l,9223372036854775807l,00l]);x.rename!(`row1`row2`row3,`col1`col2);x")
            expect <- matrix(c(0L, 9223372036854775807, NA_real_, 0L, 9223372036854775807, NA_real_), nrow = 3, byrow = FALSE)
            colnames(expect) <- c("col1", "col2")
            rownames(expect) <- c("row1", "row2", "row3")
            test$assert(result, expect)
        }
    )

    # date
    test$add_case(
        "download matrix date",
        function(conn){
            result <- dbRun(conn, "x=matrix([1970.01.01d,00d],[1970.01.01d,00d]);x.rename!(`row1`row2,`col1`col2);x")
            expect <- matrix(c("1970-01-01", NA, "1970-01-01", NA), nrow = 2, byrow = FALSE)
            colnames(expect) <- c("col1", "col2")
            rownames(expect) <- c("row1", "row2")
            test$assert(result, expect)
        }
    )

    # month
    test$add_case(
        "download matrix month",
        function(conn){
            result <- dbRun(conn, "x=matrix([1970.01M,00M],[1970.01M,00M]);x.rename!(`row1`row2,`col1`col2);x")
            expect <- matrix(c("1970-01-01", NA, "1970-01-01", NA), nrow = 2, byrow = FALSE)
            colnames(expect) <- c("col1", "col2")
            rownames(expect) <- c("row1", "row2")
            test$assert(result, expect)
        }
    )

    # time
    test$add_case(
        "download matrix time",
        function(conn){
            result <- dbRun(conn, "x=matrix([13:30:10.008t,00t],[13:30:10.008t,00t]);x.rename!(`row1`row2,`col1`col2);x")
            expect <- matrix(c("1970-01-01 13:30:10", NA, "1970-01-01 13:30:10", NA), nrow = 2, byrow = FALSE)
            colnames(expect) <- c("col1", "col2")
            rownames(expect) <- c("row1", "row2")
            test$assert(result, expect)
        }
    )

    # minute
    test$add_case(
        "download matrix minute",
        function(conn){
            result <- dbRun(conn, "x=matrix([13:30m,00m],[13:30m,00m]);x.rename!(`row1`row2,`col1`col2);x")
            expect <- matrix(c("1970-01-01 13:30:00", NA, "1970-01-01 13:30:00", NA), nrow = 2, byrow = FALSE)
            colnames(expect) <- c("col1", "col2")
            rownames(expect) <- c("row1", "row2")
            test$assert(result, expect)
        }
    )

    # second
    test$add_case(
        "download matrix second",
        function(conn){
            result <- dbRun(conn, "x=matrix([13:30:10s,00s],[13:30:10s,00s]);x.rename!(`row1`row2,`col1`col2);x")
            expect <- matrix(c("1970-01-01 13:30:10", NA, "1970-01-01 13:30:10", NA), nrow = 2, byrow = FALSE)
            colnames(expect) <- c("col1", "col2")
            rownames(expect) <- c("row1", "row2")
            test$assert(result, expect)
        }
    )

    # datetime
    test$add_case(
        "download matrix datetime",
        function(conn){
            result <- dbRun(conn, "x=matrix([2012.06.13T13:30:10D,00D],[2012.06.13T13:30:10D,00D]);x.rename!(`row1`row2,`col1`col2);x")
            expect <- matrix(c("2012-06-13 13:30:10", NA, "2012-06-13 13:30:10", NA), nrow = 2, byrow = FALSE)
            colnames(expect) <- c("col1", "col2")
            rownames(expect) <- c("row1", "row2")
            test$assert(result, expect)
        }
    )

    # timestamp
    test$add_case(
        "download matrix timestamp",
        function(conn){
            result <- dbRun(conn, "x=matrix([2012.06.13T13:30:10.008T,00T],[2012.06.13T13:30:10.008T,00T]);x.rename!(`row1`row2,`col1`col2);x")
            expect <- matrix(c("2012-06-13 13:30:10", NA, "2012-06-13 13:30:10", NA), nrow = 2, byrow = FALSE)
            colnames(expect) <- c("col1", "col2")
            rownames(expect) <- c("row1", "row2")
            test$assert(result, expect)
        }
    )

    # nanotime
    test$add_case(
        "download matrix nanotime",
        function(conn){
            result <- dbRun(conn, "x=matrix([13:30:10.008007006n,00n],[13:30:10.008007006n,00n]);x.rename!(`row1`row2,`col1`col2);x")
            expect <- matrix(c("1970-01-01 13:30:10", NA, "1970-01-01 13:30:10", NA), nrow = 2, byrow = FALSE)
            colnames(expect) <- c("col1", "col2")
            rownames(expect) <- c("row1", "row2")
            test$assert(result, expect)
        }
    )

    # nanotimestamp
    test$add_case(
        "download matrix nanotimestamp",
        function(conn){
            result <- dbRun(conn, "x=matrix([2012.06.13T13:30:10.008007006N,00N],[2012.06.13T13:30:10.008007006N,00N]);x.rename!(`row1`row2,`col1`col2);x")
            expect <- matrix(c("2012-06-13 13:30:10", NA, "2012-06-13 13:30:10", NA), nrow = 2, byrow = FALSE)
            colnames(expect) <- c("col1", "col2")
            rownames(expect) <- c("row1", "row2")
            test$assert(result, expect)
        }
    )

    # float
    test$add_case(
        "download matrix float",
        function(conn){
            result <- dbRun(conn, "x=matrix([0.0f,float('nan'),float('inf'),00f],[0.0f,float('nan'),float('inf'),00f]);x.rename!(`row1`row2`row3`row4,`col1`col2);x")
            expect <- matrix(c(0, NaN, Inf, NA_real_, 0, NaN, Inf, NA_real_), nrow = 4, byrow = FALSE)
            colnames(expect) <- c("col1", "col2")
            rownames(expect) <- c("row1", "row2", "row3", "row4")
            test$assert(result, expect)
        }
    )

    # double
    test$add_case(
        "download matrix double",
        function(conn){
            result <- dbRun(conn, "x=matrix([0.0F,00F],[0.0F,00F]);x.rename!(`row1`row2,`col1`col2);x")
            expect <- matrix(c(0, NA_real_, 0, NA_real_), nrow = 2, byrow = FALSE)
            colnames(expect) <- c("col1", "col2")
            rownames(expect) <- c("row1", "row2")
            test$assert(result, expect)
        }
    )

    # string
    test$add_case(
        "download matrix string",
        function(conn){
            result <- dbRun(conn, "x=matrix([`a,\"\"],[`a,\"\"]);x.rename!(`row1`row2,`col1`col2);x")
            expect <- matrix(c("a", NA_character_, "a", NA_character_), nrow = 2, byrow = FALSE)
            colnames(expect) <- c("col1", "col2")
            rownames(expect) <- c("row1", "row2")
            test$assert(result, expect)
        }
    )

    # symbol
    test$add_case(
        "download matrix symbol",
        function(conn){
            result <- dbRun(conn, "x=symbol([`a,\"\",`a,\"\"])$2:2;x.rename!(`row1`row2,`col1`col2);x")
            expect <- matrix(c("a", NA_character_, "a", NA_character_), nrow = 2, byrow = FALSE)
            colnames(expect) <- c("col1", "col2")
            rownames(expect) <- c("row1", "row2")
            test$assert(result, expect)
        }
    )

}