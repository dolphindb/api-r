if (!exists("TESTUPLOADMATRIX_R__", envir = .GlobalEnv)){
    TESTUPLOADMATRIX_R__ <- NULL
    source("pub/Test.R")

    library(RDolphinDB)

    # bool
    test$add_case(
        "upload matrix bool",
        function(conn){
            data <- matrix(c(TRUE, FALSE, NA, TRUE, FALSE, NA), nrow = 3, byrow = FALSE)
            colnames(data) <- c("col1", "col2")
            rownames(data) <- c("row1", "row2", "row3")
            state <- dbUpload(conn, "x", list(data))
            result <- dbRun(conn, "
                data=matrix([true false 00b,true false 00b]);
                data.rename!(`row1`row2`row3,`col1`col2);
                eqObj(data,x)
            ")
            test$assert(list(state, result), list(TRUE, TRUE))
        }
    )

    # int
    test$add_case(
        "upload matrix int",
        function(conn){
            data <- matrix(c(0L, 2147483647L, -2147483647L, NA, 0L, 2147483647L, -2147483647L, NA), nrow = 4, byrow = FALSE)
            colnames(data) <- c("col1", "col2")
            rownames(data) <- c("row1", "row2", "row3", "row4")
            state <- dbUpload(conn, "x", list(data))
            result <- dbRun(conn, "
                data=matrix([0i 2147483647i -2147483647i 00i,0i 2147483647i -2147483647i 00i]);
                data.rename!(`row1`row2`row3`row4,`col1`col2);
                eqObj(data,x)
            ")
            test$assert(list(state, result), list(TRUE, TRUE))
        }
    )

    # double
    test$add_case(
        "upload matrix double",
        function(conn){
            data <- matrix(c(0, 3.14, -3.14, NA, 0, 3.14, -3.14, NA), nrow = 4, byrow = FALSE)
            colnames(data) <- c("col1", "col2")
            rownames(data) <- c("row1", "row2", "row3", "row4")
            state <- dbUpload(conn, "x", list(data))
            result <- dbRun(conn, "
                data=matrix([0F 3.14F -3.14F 00F,0F 3.14F -3.14F 00F]);
                data.rename!(`row1`row2`row3`row4,`col1`col2);
                eqObj(data,x)
            ")
            test$assert(list(state, result), list(TRUE, TRUE))
        }
    )
    # not support string
}