if (!exists("TESTRPCBASIC_R__", envir = .GlobalEnv)){
    TESTRPCBASIC_R__ <- NULL
    source("pub/Test.R")

    library(RDolphinDB)

    # 0 params
    test$add_case(
        "test dbRpc 0 params",
        function(conn){
            . <- dbRun(conn, "
                def test_rpc0(){
                    return true
                }
            ")
            result <- dbRpc(conn, "test_rpc0", list())
            test$assert(result, TRUE)
        }
    )

    # 1 params
    test$add_case(
        "test dbRpc 1 params",
        function(conn){
            . <- dbRun(conn, "
                def test_rpc1(x){
                    return true
                }
            ")
            result <- dbRpc(conn, "test_rpc1", list(1))
            test$assert(result, TRUE)
        }
    )

    # 2 params
    test$add_case(
        "test dbRpc 2 params",
        function(conn){
            . <- dbRun(conn, "
                def test_rpc2(x,y){
                    return true
                }
            ")
            result <- dbRpc(conn, "test_rpc2", list(1, 2))
            test$assert(result, TRUE)
        }
    )

    # part apply
    test$add_case(
        "test dbRpc part apply",
        function(conn){
            . <- dbRun(conn, "
                def test_rpc_part_apply(x,y){
                    return true
                }
            ")
            result <- dbRpc(conn, "test_rpc_part_apply{0}", list(1))
            test$assert(result, TRUE)
        }
    )
}