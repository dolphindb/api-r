
#' assert function for testing
#' 
#' @param record to record results
#' first-assert true case
#' second-all case
#' @param item explanatirt note
#' @param source the source object
#' @param target the expect object
#' @param mode "equal" or "in",default "equal"
#' 
#' @return return record
assert <- function(record,item,source,target,mode="equal"){
    if (!(tolower(mode) %in% c("equal","in"))){
        print(paste("ITEM:",item,"mode not support:",mode,"!"))
    } else if (mode=="equal" && typeof(source)==typeof(target) && all.equal(source,target) == TRUE){
        record[1] <- record[1] + 1L
    } else if (mode=="in" && typeof(source)==typeof(target) && all(source %in% target) && all(target %in% source)){
        record[1] <- record[1] + 1L
    } else {
        print(paste("ITEM:",item,"assert false! source:",toString(source),"target:",toString(target)))
    }
    record[2] <- record[2] + 1L
    record
}

#' print result from record
#' @param record the record results
printTestResult <- function(record){
    print(paste("RESULT:success/total",as.character(record[1]),"/",as.character(record[2])))
}