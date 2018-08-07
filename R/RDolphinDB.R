# 
#
# @Author -- Jingtang Zhang
# @Date   -- 2018.7.13, Hangzhou
# @Update -- 2018.8.2, Hangzhou
#
# @description The definition and part of implementation of class 'RDolphinDB'
# @description The comments with [#'] is used for generating documents automatically
# 
# In R CMD, type devtools::document() to generate documents.
# A function with '@export' will be output to NAMESPACE,
# which can be called outside the package.
#
# To generate document for package, modify file DESCRIPTION.
# To generate documents for functions, modify comment below.
# Then use devtools::document() to override old documents.
#

setClass("RDolphinDB", slots = list(connected = "logical"))

#' @title dbConnect
#'
#' @description Method of getting connection with DolphinDB server.
#' @description (If the input contains 'username' and 'password', a log-in job will be done)
#' @param conn The connector object.
#' @param host The host running the DolphinDB server.
#' @param port The port running the DolphinDB server.
#' @param username The username to login onto server. (NULL if default)
#' @param password The password to login onto server. (NULL if default)
#' @return Return the connector object with status of connection.
#' @export
#' @examples
#' conn <- dbConnect(DolphinDB(), "localhost", 8848)    # Without log-in
#' # conn <- dbConnect(DolphinDB(), "localhost", 8848, "username", "password")
#' 
#' if (conn@connected == TRUE) {
#'     # TO DO ...
#'     # dbRun(...)
#' }
setGeneric(
    "dbConnect",
    function(conn, host, port, username = NULL, password = NULL) {
        standardGeneric("dbConnect")
    }
)
setMethod(
    "dbConnect",
    signature(conn = "RDolphinDB"),
    function(conn, host, port, username = NULL, password = NULL) {
        # Check input
        if (!is.null(username)) {
            if (!is.character(username)) {
                print("'username' should be a character")
                return (NULL)
            }
        }
        if (!is.null(password)) {
            if (!is.character(password)) {
                print("'password' should be a character")
                return (NULL)
            }
        }
        
        # Connect
        xxdb_stat <- Connect(host, port)
        conn@connected <- xxdb_stat

        # Log In
        if ((!is.null(username)) && (!is.null(password))) {
            DDB_RPC("login", list(username, password))
        }

        return (conn)
    }
)

#' @title dbRun
#'
#' @description Method of running scripts on DolphinDB.
#' @param conn The connector object.
#' @param script The script running the DolphinDB server.
#' @return Return the excuted result of script from server in R type.
#' @export
#' @examples
#' result <- dbRun(conn, "matrix(1.5 2.5 3.5, 4 NULL 6)")
#' print(result)
setGeneric(
    "dbRun",
    function(conn, script) {
        standardGeneric("dbRun")
    }
)
setMethod(
    "dbRun",
    signature(conn = "RDolphinDB"),
    function(conn, script) {
        type <- RunScript(script)
        DDB_GetEntity(type)
    }
)

#' @title dbRpc
#'
#' @description Method of running remote procedure call.
#' @param conn The connector object.
#' @param func The function name running on the DolphinDB server.
#' @param args The list containing all arguments needed to be uploaded to server.
#' @return Return the excuted result of function from server in R type.
#' @export
#' @examples
#' result <- dbRpc(conn, "concat", list("hello", "world"))
#' print(result)
setGeneric(
    "dbRpc",
    function(conn, func, args) {
        standardGeneric("dbRpc")
    }
)
setMethod(
    "dbRpc",
    signature(conn = "RDolphinDB"),
    function(conn, func, args) {
        # Check input
        if (class(func) != "character") {
            print("Error: parameter 'func' must be a string")
            return (NULL)
        }
        if (class(args) != "list") {
            print("Error: parameter 'args' must be a list")
            return (NULL)
        } 
        # Execute RPC
        res_entity <- DDB_RPC(func, args)
        return (res_entity)
    }
)

#' @title dbUpload
#'
#' @description Method of uploading arguments to DolphinDB.
#' @param conn The connector object.
#' @param keys The variable names. (Cannot be repeated)
#' @param args The list containing all arguments needed to be uploaded to server.
#' @return Return the excuted result of uploading.
#' @export
#' @examples
#' result <- dbUpload(conn, c("x", "y"), list(2.5L, "hello"))
#' if (result == TRUE) {
#'     r_x <- dbRun(conn, "x")
#'     r_y <- dbRun(conn, "y")
#'     print(r_x)
#'     print(r_y)   
#' }
setGeneric(
    "dbUpload",
    function(conn, keys, args) {
        standardGeneric("dbUpload")
    }
)
setMethod(
    "dbUpload",
    signature(conn = "RDolphinDB"),
    function(conn, keys, args) {
        # Check input
        if (!is.character(keys)) {
            print("'Keys' should be a character vector")
            return (NULL)
        }
        if (!is.list(args)) {
            print("'args' should be uploaded in a list")
            return (NULL)
        }
        if (length(unique(keys)) != length(args)) {
            print("Repeat keys in 'Keys'")
            return (NULL)
        }
        if (!DDB_UploadObjectCheck(args)) {
            return (NULL)
        }
        # Write header
        writable <- RunUploadInit(keys)
        if (writable == FALSE) {
            return (NULL)
        }
        # Upload entity
        DDB_UploadEntity(args)
        # Get status
        res_stat <- ReceiveHeader()
        return (res_stat)
    }
)

#' @title dbClose
#'
#' @description Method of closing connection with DolphinDB server.
#' @param conn The connector object.
#' @export
#' @examples
#' dbClose(conn)
setGeneric(
    "dbClose",
    function(conn) {
        standardGeneric("dbClose")
    }
)
setMethod(
    "dbClose",
    signature(conn = "RDolphinDB"),
    function(conn) {
        DisConnect()
        object@connected <- FALSE
    }
)

obj <- new("RDolphinDB")

#' @title DolphinDB
#'
#' @description Method to getting an object of connector.
#' @export
#' @examples
#' conn <- DolphinDB()
#' conn <- dbConnect(conn, "localhost", 8848)
#' 
#' # Recommanded
#' conn <- dbConnect(DolphinDB(), "localhost", 8848)
DolphinDB <- function() {
    return (obj)
}

