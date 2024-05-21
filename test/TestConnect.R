if (!exists("TESTCONNECT_R__", envir = .GlobalEnv)){
    TESTCONNECT_R__ <- NULL
    source("pub/Test.R")

    library(RDolphinDB)

    # host error
    test$add_case(
        "host error",
        function(conn){
            .conn <- dbConnect(DolphinDB(), "192.1.1.1", PORT)
            test$assert(.conn@connected, FALSE)
        }
    )

    # port error
    test$add_case(
        "port error",
        function(conn){
            .conn <- dbConnect(DolphinDB(), HOST, 22)
            test$assert(.conn@connected, FALSE)
        }
    )

    # user error
    test$add_case(
        "user error",
        function(conn){
            .conn <- dbConnect(DolphinDB(), HOST, PORT, "dolphindb", PASSWD)

            test$assert(.conn@connected, TRUE)
        }
    )

    # password error
    test$add_case(
        "password error",
        function(conn){
            .conn <- dbConnect(DolphinDB(), HOST, PORT, USER, "111111")
            test$assert(.conn@connected, TRUE)
        }
    )
}