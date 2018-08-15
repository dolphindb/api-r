# 
#
# @Author -- Jingtang Zhang
# @Date   -- 2018.7.13, Hangzhou
# @Update -- 2018.8.2, Hangzhou
#
# @description Implementation of class 'RDolphinDB'
#

# @Function
#   Set all NA for a received vector,
#   according to an Index vector.
DDB_SetReceiveVectorNA <- function(temp, NAIndex) {
    for (i in NAIndex) {
        temp[i] <- NA
    }
    return (temp)
}

# @Function
#   Generate an Index vector for a vector
#   which will be uploaded
#   (Used for dealing with NULLs in C++)
DDB_SetUploadVectorNA <- function(vec) {
    NAIndex <- vector(mode = "integer", length = 0)
    for (j in 1:length(vec)) {
        if (is.na(vec[j]) == TRUE) {
            NAIndex <- c(NAIndex, j-1)
        }
    }
    return (NAIndex)
}

# @Function
#   Used for receiving row and column lables of a matrix.
#   Lable needs to be a vector.
DDB_ReceiveMatrixLable <- function(temp) {
    if (ReturnMatrixHasLable(TRUE)) {
        type <- ReturnMatrixLableType(TRUE)
        if (type == 5) {
            result <- ReturnMatrixVectorBoolLable(TRUE)
            result <- DDB_SetReceiveVectorNA(result, ReturnMatrixLableNAIndex(TRUE))

        } else if (type == 6) {
            result <- ReturnMatrixVectorIntLable(TRUE)

        } else if (type == 7) {
            result <- ReturnMatrixVectorDoubleLable(TRUE)
            result <- DDB_SetReceiveVectorNA(result, ReturnMatrixLableNAIndex(TRUE))

        } else if (type == 8) {
            result <- ReturnMatrixVectorStringLable(TRUE)

        } else {
            # ERROR
        }
        rownames(temp) <- result
    }
    if (ReturnMatrixHasLable(FALSE)) {
        type <- ReturnMatrixLableType(FALSE)
        if (type == 5) {
            result <- ReturnMatrixVectorBoolLable(FALSE)
            result <- DDB_SetReceiveVectorNA(result, ReturnMatrixLableNAIndex(FALSE))

        } else if (type == 6) {
            result <- ReturnMatrixVectorIntLable(FALSE)

        } else if (type == 7) {
            result <- ReturnMatrixVectorDoubleLable(FALSE)
            result <- DDB_SetReceiveVectorNA(result, ReturnMatrixLableNAIndex(FALSE))

        } else if (type == 8) {
            result <- ReturnMatrixVectorStringLable(FALSE)

        } else {
            # ERROR
        }
        colnames(temp) <- result
    }
    return (temp)
}

# @Function
#   According to the type number defined in R_Type.h,
#   call the different C++ functions to receive 
#   different types of entity in R type.
#   At the same time, deal with NULLs in entities.
DDB_GetEntity <- function(xxdb_type) {
    # xxdb_type are defined in R_Type.h

    if (xxdb_type == 0) {
        # void
        Clear()
        return (NA)

    } else if (xxdb_type == 1) {
        # Scalar Logical
        if (ReturnScalarNA()) {
            result <- NA
        } else {
            result <- ReturnScalarBool()
        }
        Clear()
        return (result)

    } else if (xxdb_type == 2) {
        # Scalar Integer
        if (ReturnScalarNA()) {
            result <- NA
        } else {
            result <- ReturnScalarInt()
        }
        Clear()
        return (result)

    } else if (xxdb_type == 3) {
        # Scalar Numeric
        if (ReturnScalarNA()) {
            result <- NA
        } else {
            result <- ReturnScalarDouble()
        }
        Clear()
        return (result)

    } else if (xxdb_type == 4) {
        # Scalar Character
        if (ReturnScalarNA()) {
            result <- NA
        } else {
            result <- ReturnScalarString()
        }
        Clear()
        return (result)

    } else if (xxdb_type == 14) {
        # Scalar Date
        if (ReturnScalarNA()) {
            result <- NA
        } else {
            result <- ReturnScalarString()
        }
        Clear()
        return (as.Date(result))

    } else if (xxdb_type == 15) {
        # Scalar DateTime
        if (ReturnScalarNA()) {
            result <- NA
        } else {
            result <- ReturnScalarString()
        }
        Clear()
        return (as.POSIXct(result))

    } else if (xxdb_type == 5) {
        # Logical Vector
        result <- ReturnVectorBool()
        result <- DDB_SetReceiveVectorNA(result, ReturnVectorNAIndex())
        Clear()
        return (result)

    } else if (xxdb_type == 6) {
        # Integer Vector
        result <- ReturnVectorInt()
        Clear()
        return (result)

    } else if (xxdb_type == 7) {
        # Numeric Vector
        result <- ReturnVectorDouble()
        result <- DDB_SetReceiveVectorNA(result, ReturnVectorNAIndex())
        Clear()
        return (result)

    } else if (xxdb_type == 8) {
        # Character Vector
        result <- ReturnVectorString()
        result <- DDB_SetReceiveVectorNA(result, ReturnVectorNAIndex())
        Clear()
        return (result)

    } else if (xxdb_type == 16) {
        # Vector Date
        result <- ReturnVectorString()
        result <- DDB_SetReceiveVectorNA(result, ReturnVectorNAIndex())
        Clear()
        return (as.Date(result))

    } else if (xxdb_type == 17) {
        # Vector DateTime
        result <- ReturnVectorString()
        result <- DDB_SetReceiveVectorNA(result, ReturnVectorNAIndex())
        Clear()
        return(as.POSIXct(result))

    } else if (xxdb_type == 9) {
        # Logical Matrix
        result <- ReturnMatrixBool()
        result <- DDB_SetReceiveVectorNA(result, ReturnMatrixNAIndex())
        result <- DDB_ReceiveMatrixLable(result)
        Clear()
        return (result)

    } else if (xxdb_type == 10) {
        # Integer Matrix
        result <- ReturnMatrixInt()
        result <- DDB_ReceiveMatrixLable(result)
        Clear()
        return (result)

    } else if (xxdb_type == 11) {
        # Numeric Matrix
        result <- ReturnMatrixDouble()
        result <- DDB_SetReceiveVectorNA(result, ReturnMatrixNAIndex())
        result <- DDB_ReceiveMatrixLable(result)
        Clear()
        return (result)
        
    } else if (xxdb_type == 18) {
        # Matrix Date
        result <- ReturnMatrixString()
        result <- DDB_SetReceiveVectorNA(result, ReturnMatrixNAIndex())
        result <- DDB_ReceiveMatrixLable(result)
        Clear()
        return (result)

    } else if (xxdb_type == 19) {
        # Matrix DateTime
        result <- ReturnMatrixString()
        result <- DDB_SetReceiveVectorNA(result, ReturnMatrixNAIndex())
        result <- DDB_ReceiveMatrixLable(result)
        Clear()
        return (result)

    } else if (xxdb_type == 12) {
        # Character Matrix
        return (NULL)

    } else if (xxdb_type == 13) {
        # DataFrame
        result <- ReturnEmptyDataFrame()
        typelist <- ReturnTableColumnType()

        for (i in 1:length(typelist)) {
            if (typelist[i] == 5) {
                clm <- ReturnTableColumnLogical(i)
                NAIndex <- ReturnTableColumnNAIndex(i)
                for (j in NAIndex) {
                    clm[j] <- NA
                }
                result <- cbind(result, clm)

            } else if (typelist[i] == 6) {
                clm <- ReturnTableColumnInteger(i)
                result <- cbind(result, clm)

            } else if (typelist[i] == 7) {
                clm <- ReturnTableColumnDouble(i)
                NAIndex <- ReturnTableColumnNAIndex(i)
                for (j in NAIndex) {
                    clm[j] <- NA
                }
                result <- cbind(result, clm)

            } else if (typelist[i] == 8) {
                clm <- ReturnTableColumnString(i)
                result <- cbind(result, clm)

            } else {
                print("error in DataFrame")
                return (NULL)
            }
        }
        
        result <- result[,-1]
        colnames(result) <- ReturnTableColumeName()
        Clear()
        return (result)

    } else {
        # print("Error")
        Clear()
        return (NULL)
    }
}

# @Function
#   According to the type of R object,
#   call different C++ functions to upload 
#   different types of R objects.
DDB_UploadScalar <- function(scl) {
    if (is.na(scl) || is.nan(scl)) {
        
        UploadScalarNULL()

    } else if (is.logical(scl)) {

        UploadScalarBool(scl)

    } else if (is.integer(scl)) {

        UploadScalarInt(scl)

    } else if (is.numeric(scl)) {
        
        UploadScalarDouble(scl)

    } else if (is.character(scl)) {

        UploadScalarString(scl)

    } else {
        print("[ERROR] Scalar type not support yet.")
    }
}

# @Function
#   Parse a date type to C++ string to upload
DDB_UploadScalarDate <- function(date) {
    UploadScalarDate(as.character(date))
}

# @Function
#   Parse a date type vector to C++ string vector to upload,
#   at the same time, deal with NA in vector
DDB_UploadVectorDate <- function(vec) {
    date_str_vec <- vector(mode = "character", length = 0)
    for (i in 1:length(vec)) {
        date_str_vec <- c(date_str_vec, as.character(vec[i]))
    }
    NAIndex <- DDB_SetUploadVectorNA(vec)
    UploadVectorDate(date_str_vec, NAIndex)
}

# @Function
#   Parse a datetime type to C++ string to upload.
DDB_UploadScalarDateTime <- function(datetime) {
    UploadScalarDateTime(as.character(datetime))
}

# @Function
#   Parse a datetime type vector to C++ string vector to upload
#   at the same time, deal with NA in vector
DDB_UploadVectorDateTime <- function(vec) {
    date_time_str_vec <- vector(mode = "character", length = 0)
    for (i in 1:length(vec)) {
        date_time_str_vec <- c(date_time_str_vec, as.character(vec[i]))
    }
    NAIndex <- DDB_SetUploadVectorNA(vec)
    UploadVectorDateTime(date_time_str_vec, NAIndex)
}

# @Function
#   According to the type of vector,
#   call different C++ functions to upload vectors.
#   At the same time, deal with NA in vectors.
DDB_UploadVector <- function(vec) {
    if (all(is.na(vec))) {

        UploadVectorNULL(length(vec), 1L)

    } else if (is.logical(vec)) {

        NAIndex <- DDB_SetUploadVectorNA(vec)
        UploadVectorBool(vec, NAIndex)

    } else if (is.integer(vec)) {

        NAIndex <- DDB_SetUploadVectorNA(vec)
        UploadVectorInt(vec, NAIndex)

    } else if (is.numeric(vec)) {

        NAIndex <- DDB_SetUploadVectorNA(vec)
        UploadVectorDouble(vec, NAIndex)

    } else if (is.character(vec)) {

        NAIndex <- DDB_SetUploadVectorNA(vec)
        UploadVectorString(vec, NAIndex)

    } else {
        print("[ERROR] Vector type not support yet.")
        return (NULL)
    }

    return (TRUE)
}

# @Function
#   Call C++ function to upload lables of a matrix
DDB_UploadMatrixLable <- function(mtx) {

    lableFlag <- 0L
    if (is.null(rownames(mtx)) == FALSE) {
        lableFlag <- lableFlag + 1L
    }
    if (is.null(colnames(mtx)) == FALSE) {
        lableFlag <- lableFlag + 2L
    }

    UploadMatrixLableFlag(lableFlag)

    if (is.null(rownames(mtx)) == FALSE) {
        DDB_UploadVector(rownames(mtx))
    }
    if (is.null(colnames(mtx)) == FALSE) {
        DDB_UploadVector(rownames(mtx))
    }
}

# @Fucntion
#   According to the type of matrix,
#   call different functions to upload matrix.
#   At the same time, deal with NA in matrix.
DDB_UploadMatrix <- function(mtx) {

    if (all(is.na(mtx))) {

        UploadMatrixFlag(16)
        DDB_UploadMatrixLable(mtx)
        UploadMatrixFlag(16)
        UploadMatrixNULL(nrow(mtx), ncol(mtx))

    } else if (is.logical(mtx)) {

        UploadMatrixFlag(1)
        DDB_UploadMatrixLable(mtx)
        UploadMatrixFlag(1)
        UploadMatrixBool(mtx, DDB_SetUploadVectorNA(mtx))

    } else if (is.integer(mtx)) {

        UploadMatrixFlag(4)
        DDB_UploadMatrixLable(mtx)
        UploadMatrixFlag(4)
        UploadMatrixInt(mtx, DDB_SetUploadVectorNA(mtx))

    } else if (is.numeric(mtx)) {

        UploadMatrixFlag(16)
        DDB_UploadMatrixLable(mtx)
        UploadMatrixFlag(16)
        UploadMatrixDouble(mtx, DDB_SetUploadVectorNA(mtx))

    } else {
        print("Data form not support yet")
        return (NULL)
    }
}

# @Function
#   First, upload the basic info of a table.
#   Then, upload every column of table as vectors
DDB_UploadTable <- function(tbl) {
    UploadTableBasic(nrow(tbl), ncol(tbl), colnames(tbl))
    for (i in 1:ncol(tbl)) {
        DDB_UploadVector(tbl[,i])
    }
}

# @Function
#   Check every elements in argument list,
#   If there is one argument whose type is not supported,
#   return false to stop uploading.
DDB_UploadObjectCheck <- function(args) {
    for (i in 1:length(args)) {
        if (is.matrix(args[[i]])) {
            
        } else if (is.data.frame(args[[i]])) {
            
        } else if (is.vector(args[[i]]) && length(args[[i]]) > 1) {
            
        } else if (is.vector(args[[i]]) && length(args[[i]]) == 1) {
            
        } else if (class(args[[i]]) == "Date" && length(args[[i]]) == 1) {
            
        } else if (class(args[[i]]) == "Date" && length(args[[i]]) > 1) {
            
        } else if (class(args[[i]]) == c("POSIXct", "POSIXt") && length(args[[i]]) == 1) {
            
        } else if (class(args[[i]]) == c("POSIXct", "POSIXt") && length(args[[i]]) > 1) {
            
        } else {
            print("Data form not support yet.")
            return (FALSE)
        }
    }

    return (TRUE)
}

# @Function
#   According to the data form of R object,
#   call the different functions to upload
#   different forms of objects.
DDB_UploadEntity <- function(args) {
    for (i in 1:length(args)) {
        if (is.matrix(args[[i]])) {
            DDB_UploadMatrix(args[[i]])
        } else if (is.data.frame(args[[i]])) {
            DDB_UploadTable(args[[i]])
        } else if (is.vector(args[[i]]) && length(args[[i]]) > 1) {
            DDB_UploadVector(args[[i]])
        } else if (is.vector(args[[i]]) && length(args[[i]]) == 1) {
            DDB_UploadScalar(args[[i]])
        } else if (class(args[[i]]) == "Date" && length(args[[i]]) == 1) {
            DDB_UploadScalarDate(args[[i]])
        } else if (class(args[[i]]) == "Date" && length(args[[i]]) > 1) {
            DDB_UploadVectorDate(args[[i]])
        } else if (class(args[[i]]) == c("POSIXct", "POSIXt") && length(args[[i]]) == 1) {
            DDB_UploadScalarDateTime(args[[i]])
        } else if (class(args[[i]]) == c("POSIXct", "POSIXt") && length(args[[i]]) > 1) {
            DDB_UploadVectorDateTime(args[[i]])
        } else {
            print("Data form not support yet")
            Clear()
            return (NULL)
        }
    }
}

# @Function
#   The basic procedure of RPC.
#   First, write headers.
#   Then, upload entities.
#   At last, get entity result.
DDB_RPC <- function(func, args) {
    # Write init
    writable <- RunFunctionInit(func, length(args))
    if (writable == FALSE) {
        return (NULL)
    }

    # Write Entity
    DDB_UploadEntity(args)

    # Get Entity
    res_type <- ReceiveEntity()
    res_entity <- DDB_GetEntity(res_type)
    return (res_entity)
}