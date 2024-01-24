# R API

DolphinDB 提供了 R API 便于用户通过 R 语言操作 DolphinDB。DolphinDB R API 是由 R 和 C++ 实现的，使用的 C++ 包是 Rcpp。

DolphinDB R API支持以下功能：

- 运行脚本
- 执行DolphinDB中的函数
- 上传变量到DolphinDB

## 依赖

- R ( ≥ 3. 2. 0)
- Rcpp ( ≥ 0. 12. 17)

## 安装 

### 准备 R 环境

- Linux系统：

    - 执行 `sudo apt-get install r-base` 安装R
    - 或者从 [R官网](https://www.r-project.org/) 手动下载安装

- Windows系统：

    - 从 [R官网](https://www.r-project.org/) 下载并安装 R API和 rtools

安装时需要配置好环境变量和路径。

### 进入 R 命令行

在终端或命令行中输入 `R` 进入 R 命令行。

### 安装 devtools

在R命令行中输入`install.packages("devtools")`，选择最近的镜像下载并安装。

### 通过 devtools 安装 DolphinDB R API

在 R 命令行中输入 `devtools::install_github("dolphindb/api-r")`，系统自动会下载并安装 DolphinDB R API 以及它所依赖的包。

如果在 Windows 系统上安装时出现 *Warning in system(cmd) : 'make' not found.*  的错误信息，可以在 R 命令行中执行以下代码。安装完成后，程序包将由 g++ 自动编译和链接。

  ```R
  Sys.setenv(PATH = paste("*InstallDirectory*/Rtools/bin", Sys.getenv("PATH"), sep=";"))
  Sys.setenv(BINPREF = "*InstallDirectory*/Rtools/mingw_64/bin") 
  ```

### 使用DolphinDB R API

假设 DolphinDB 运行在主机名为 localhost，端口号为 8848 的服务器上，我们可以通过以下方式来连接 DolphinDB、上传对象和执行脚本：

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


## 数据类型支持一览

R API 支持的 DolphinDB 数据类型如下：

| DolphinDB类型 | DolphinDB中数据示例 | R语言类型 | R语言中数据示例 | 说明 |
|---|---|---|---|---|
| BOOL | false | Logical | FALSE |   |
| CHAR | 'A' | Integer | 65 |   |
| SHORT | 32 | Integer | 32 |   |
| INT | 1 | Integer | 1 |   |
| LONG | 100000 | Numeric | 10000 | 因为R的整形最大就是2147483647 |
| DATE | 2013.06.13 | Date | 2013-06-13 |   |
| MONTH | 2013.08M | Date | 2013-08-01 | 指定为当月第一天 |
| TIME | 13:30:10.008 | POSIXct | 1970-01-01 13:30:10 | 指定为1970.01.01那天的该时刻 |
| MINUTE | 13:30m | POSIXct | 1970-01-01 13:30:00 | 指定为1970.01.01那天的该时刻 |
| SECOND | 13:30:10 | POSIXct | 1970-01-01 13:30:10 | 指定为1970.01.01那天的该时刻 |
| DATETIME | 2012.06.13T13:30:10 | POSIXct | 2012-06-13 13:30:10 |   |
| TIMESTAMP | 2012.06.13T13:30:10.008 | POSIXct | 2012-06-13 13:30:10 |   |
| NANOTIME | 13:30:10.008007006 | POSIXct | 1970-01-01 13:30:10 | 指定为1970.01.01那天的该时刻 |
| NANOTIMESTAMP | 2012.06.13T13:30:10.008007006 | POSIXct | 2012-06-13 13:30:10 |   |
| FLOAT | 2.1f | Numeric | 2.1 |   |
| DOUBLE | 2.1 | Numeric | 2.1 |   |
| STRING | “123” | character | “123” |   |
| SYMBOL |   | 不支持 |   |   |
| BLOB |   | 不支持 |   |   |
| DATEHOUR |   | 不支持 |   |   |

## 更多函数介绍

在R命令行中执行 `help` 函数可以获取更多 DolphinDB R API 中函数的用法。

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

更多关于 DolphinDB 内置函数的用法，请参考：[DolphinDB 函数参考](https://docs.dolphindb.cn/zh/funcs/funcs_intro.html)
