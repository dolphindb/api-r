if (!exists("TEST_R__", envir = .GlobalEnv)){
    TEST_R__ <- NULL
    source("setup/Settings.R")

    library(RDolphinDB)
    library(htmlTable)

    Test <- R6::R6Class(
        "Test",
        public = list(
            initialize = function(host, port, user, password, auto_test){
                private$conn <- dbConnect(DolphinDB(), host, port, user, password)
                private$auto_test <- auto_test
            },
            finalize = function(){
                private$conn <- dbClose(private$conn)
            },
            add_case = function(case_name, case_func){
                private$test_case <- append(private$test_case, list(list(case_name, case_func)))
            },
            run = function(){
                for (case in private$test_case){
                    case_name <- case[[1]]
                    tryCatch(
                        expr = {
                            case_result <- case[[2]](conn = private$conn)
                            result <- case_result[[1]]
                            error_message <- case_result[[2]]
                            . <- data.frame(
                                case_name = c(case_name),
                                result = c(result),
                                error_message = c(error_message)
                            )
                            private$result <- rbind(private$result, .)
                        },
                        error = function(e){
                            result <- FALSE
                            error_message <- e$message
                            . <- data.frame(
                                case_name = c(case_name),
                                result = c(result),
                                error_message = c(error_message)
                            )
                            private$result <- rbind(private$result, .)
                        }
                    )
                }
            },
            assert = function(source, target, mode = "equal"){
                if (!(typeof(source) == typeof(target))){
                    return(list(FALSE, paste("typeof error source:", typeof(source)[[1]], "target:", typeof(target)[[1]])))
                }
                if (!(class(source)[[1]] == class(target)[[1]])){
                    return(list(FALSE, paste("class error source:", class(source)[[1]], "target:", class(target)[[1]])))
                }
                if (mode == "equal"){
                    . <- all.equal(source, target)
                    if (inherits(., "logical")){
                        return(list(TRUE, "-"))
                    } else{
                        return(list(FALSE, paste(., collapse = "|")))
                    }
                } else if (mode == "in"){
                    . <- all(source %in% target) && all(target %in% source)
                    if (.){
                        return(list(TRUE, "-"))
                    } else{
                        return(list(FALSE, paste("assert false! source:", toString(source), "target:", toString(target))))
                    }
                } else{
                    return(list(FALSE, paste("not support", mode)))
                }
            },
            testResult = function(){
                case_count <- nrow(private$result)
                fail_case_table <- private$result[private$result$result == FALSE,]
                fail_case_count <- nrow(fail_case_table)
                overview_table <- data.frame(
                    fail_case_count = c(fail_case_count),
                    case_count = c(case_count)
                )
                if (private$auto_test){
                    css <- "
                    <style>
                        body {
                            font-family: Arial, sans-serif;
                        }
                        .gmisc_table {
                            width: 80%;
                            border-collapse: collapse;
                        }
                        .gmisc_table th, .gmisc_table td {
                            padding: 8px;
                            text-align: left;
                            border-bottom: 1px solid #ddd;
                            border: 1px solid black;
                        }
                        .gmisc_table tr:hover {
                            background-color: #f5f5f5;
                        }
                        .gmisc_table th {
                            background-color: #4CAF50;
                            color: white;
                        }
                    </style>
                    "
                    writeLines(paste(css, htmlTable(overview_table), sep = " "), "./overview.html")
                    writeLines(paste(css, htmlTable(fail_case_table), sep = " "), "./fail_case.html")
                }
                print("=====overview=====")
                print(overview_table)
                print("=====fail_case=====")
                print(fail_case_table)
            }
        ),
        private = list(
            auto_test = FALSE,
            test_case = list(),
            result = data.frame(
                case_name = character(0),
                result = logical(0),
                error_message = character(0)
            ),
            conn = NULL
        )
    )
    test <- Test$new(HOST, PORT, USER, PASSWD, AUTO_TEST)
}
