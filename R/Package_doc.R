#
#
# @Author -- Jingtang Zhang
# @Date   -- 2018.7.31
# @Update -- 2018.8.17
#
# The document commet of package 'RDolphinDB'
# The dynamic library declaration of package if using Rcpp
#
# After modifing the comments below with [#'],
# in R CMD, type devtools::document() to update document
#

#' @title RDolphinDB : Connecting to DolphinDB with R
#'
#' @description The R API of DolphinDB.
#' @description You can use R connecting to DolphinDB with IP address and port, 
#' @description and then running scripts or functions and geting result in R form.
#' 
#' @author mrDrivingDuck <jingtang.zhang@dolphindb.com>
#' @section RDolphinDB functions:
#' DolphinDB()
#' dbConnect()
#' dbRun()
#' dbRpc()
#' dbClose()
#'
#' @docType package
#' @name RDolphinDB
NULL

#' @useDynLib RDolphinDB
#' @importFrom Rcpp sourceCpp
NULL
