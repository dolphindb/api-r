if (!exists("TESTCLOSE_R__", envir = .GlobalEnv)){
    TESTCLOSE_R__ <- NULL
    source("pub/Test.R")

    library(RDolphinDB)

    # close
    test$add_case(
        "connect close",
        function(conn){
            .conn <- dbConnect(DolphinDB(), HOST, PORT)
            .conn <- dbClose(.conn)
            test$assert(.conn@connected, FALSE)
        }
    )

    # already closed
    test$add_case(
        "already closed",
        function(conn){
            .conn <- dbConnect(DolphinDB(), HOST, PORT)
            .conn <- dbClose(.conn)
            .conn <- dbClose(.conn)
            test$assert(.conn@connected, FALSE)
        }
    )
}