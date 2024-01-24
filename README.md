# _RDolphinDB_ Package

### 1. About

#### 1.1 Description

This is a R-Package which will make it easy for you to handle _DolphinDB_ with _R_.

It is implemented by _R_ & _C++_, with the help of package `Rcpp`.

The package supports :

* Running scripts
* Executing functions with arguments
* Uploading variables

on _DolphinDB_ server, while receiving object from server in the form and type of _R_.

#### 1.2 Dependency

* R ( ≥ 3. 2. 0)
* Rcpp ( ≥ 0. 12. 17)

---

### 2. Install

#### 2.1 Install _R_ Environment

* For __Linux__ user
  * `sudo apt-get install r-base`
  * __OR__ download and install manually : https://www.r-project.org/
* For __Windows__ user
  * Download and install the r base packages and the rtools at https://www.r-project.org/

#### 2.2 Get into _R_ CMD

* Type `R` in your terminal/console.
* You should have set the correct __environment variable__ and __path__ for _R_.

#### 2.3 Install _devtools_ Package in _R_

* In _R_ CMD, type `install.packages("devtools")` to install package _devtools_.
* Select the nearest mirror to download and install automatically.
* Make sure the Internet is in good condition.

#### 2.4 Install _RDolphinDB_ Package by _devtools_

* In _R_ CMD, type `devtools::install_github("dolphindb/api-r")`.
* This command will automatically download and install _RDolphinDB_ and its dependency package.
* For __Windows__ user
  * If the Installation failed with message: *Warning in system(cmd) : 'make' not found*. Just try: 
  
  ```R
  Sys.setenv(PATH = paste("*InstallDirectory*/Rtools/bin", Sys.getenv("PATH"), sep=";"))
  Sys.setenv(BINPREF = "*InstallDirectory*/Rtools/mingw_64/bin") 
  ```
  
* After installation, the package will be compiled and linked by _g++_ automatically.

#### 2.5 Use the _RDolphinDB_ Package

* Assume you are running _DolphinDB_ server on __localhost:8848__
* Then you can use `RDolphinDB` in the following way

```R
library(RDolphinDB)
conn <- dbConnect(DolphinDB(), "localhost", 8848)
if (conn@connected) {
    dbUpload(conn, c("val1", "val2"), list(3.5, c(1.3, 2.6, 3.7)))
    res_run <- dbRun(conn, "1 2 3")
    res_rpc <- dbRpc(conn, "size", list(c(1, 2, 3)))
    print(res_run)
    print(res_rpc)
}
dbClose(conn)
```

### 3. Supported Data Types

R API supports the following data types of DolphinDB:

| DolphinDB Type | DolphinDB Example | R Type | R Example | Description |
|---|---|---|---|---|
| BOOL | false | Logical | FALSE |   |
| CHAR | 'A' | Integer | 65 |   |
| SHORT | 32 | Integer | 32 |   |
| INT | 1 | Integer | 1 |   |
| LONG | 100000 | Numeric | 10000 | The maximum integer in R is 2147483647 |
| DATE | 2013.06.13 | Date | 2013-06-13 |   |
| MONTH | 2013.08M | Date | 2013-08-01 | The first day of the specified month |
| TIME | 13:30:10.008 | POSIXct | 1970-01-01 13:30:10 | The specified timestamp on 1970.01.01 (accurate to seconds) |
| MINUTE | 13:30m | POSIXct | 1970-01-01 13:30:00 | The specified timestamp on 1970.01.01 |
| SECOND | 13:30:10 | POSIXct | 1970-01-01 13:30:10 | The specified timestamp on 1970.01.01 |
| DATETIME | 2012.06.13T13:30:10 | POSIXct | 2012-06-13 13:30:10 |   |
| TIMESTAMP | 2012.06.13T13:30:10.008 | POSIXct | 2012-06-13 13:30:10 |   |
| NANOTIME | 13:30:10.008007006 | POSIXct | 1970-01-01 13:30:10 | The specified timestamp on 1970.01.01 (accurate to seconds) |
| NANOTIMESTAMP | 2012.06.13T13:30:10.008007006 | POSIXct | 2012-06-13 13:30:10 |   |
| FLOAT | 2.1f | Numeric | 2.1 |   |
| DOUBLE | 2.1 | Numeric | 2.1 |   |
| STRING | “123” | character | “123” |   |
| SYMBOL |   | Not supported |   |   |
| BLOB |   | Not supported |   |   |
| DATEHOUR |   | Not supported |   |   |

---
### 4. Documentation

#### 4.1 In _R_ CMD

```R
# About the package
help(package = "RDolphinDB")

# About the functions
help("DolphinDB")
help("dbConnect")
help("dbRun")
help("dbRpc")
help("dbUpload")
help("dbClose")
```

#### 4.2 Through our website

* www.dolphindb.com

---

