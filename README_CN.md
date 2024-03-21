# DolphinDB R包

### 1. 关于DolphinDB R包

#### 1.1 简介

DolphinDB提供了R包，用户可以通过R语言操作DolphinDB。DolphinDB R包是由R和C++实现的，使用的C++包是Rcpp。

DolphinDB R包支持以下功能：

- 运行脚本
- 执行DolphinDB中的函数
- 上传变量到DolphinDB

#### 1.2 依赖

- R ( ≥ 3. 2. 0)
- Rcpp ( ≥ 0. 12. 17)

### 2. 安装DolphinDB R包

#### 2.1 准备R环境

- Linux系统：

    - 执行`sudo apt-get install r-base`安装R
    - 或者从[R官网](https://www.r-project.org/)手动下载安装

- Windows系统：

    - 从[R官网](https://www.r-project.org/)下载并安装R包和rtools

安装时需要配置好环境变量和路径。

#### 2.2 进入R命令行

在终端或命令行中输入`R`进入R命令行。

#### 2.3 安装devtools

在R命令行中输入`install.packages("devtools")`，选择最近的镜像下载并安装。

#### 2.4 通过devtools安装DolphinDB R包

在R命令行中输入`devtools::install_github("dolphindb/api-r")`，系统自动会下载并安装DolphinDB R包以及它所依赖的包。

如果在Windows系统上安装时出现 *Warning in system(cmd) : 'make' not found.* 的错误信息，可以在R命令行中执行以下代码。安装完成后，程序包将由g++自动编译和链接。

  ```R
  Sys.setenv(PATH = paste("*InstallDirectory*/Rtools/bin", Sys.getenv("PATH"), sep=";"))
  Sys.setenv(BINPREF = "*InstallDirectory*/Rtools/mingw_64/bin") 
  ```

#### 2.5 使用DolphinDB R包

假设DolphinDB运行在主机名为localhost，端口号为8848的服务器上，我们可以通过以下方式来连接DolphinDB、上传对象和执行脚本：

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

### 3. 更多函数介绍

在R命令行中执行**help**函数可以获取更多DolphinDB R包中函数的用法。

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

更多关于DolphinDB内置函数的用法，请参考[DolphinDB用户手册](https://www.dolphindb.cn/cn/help/Chapter13FunctionsandCommands.html)。

### 4. R API支持的类型统计
注：R内置的时间类型分为日期（Date）和日期+时间（POSIXct）两种，没有单独时间类型。并且只精确到秒

|DolphinDB类型|DolphinDB数据示例|R语言类型|R语言数据示例|说明|
|:-|:-|:-|:-|:-|
|BOOL|false|Logical|FALSE|
|CHAR|'A'|Integer|65|
|SHORT|32|Integer|32|
|INT|1|Integer|1|
|LONG|100000|Numeric|100000|R的整型最大是2147483647
|DATE|2013.06.13|Date|2013-06-13|
|MONTH|2013.08M|Date|2013-08-01|指定为当月第一天
|TIME|13:30:10.008|POSIXct|1970-01-01 13:30:10|指定为1970.01.01那天的该时刻
|MINUTE|13:30m|POSIXct|1970-01-01 13:30:00|指定为1970.01.01那天的该时刻
|SECOND|13:30:10|POSIXct|1970-01-01 13:30:10|指定为1970.01.01那天的该时刻
|DATETIME|2012.06.13T13:30:10|POSIXct|2012-06-13 13:30:10|
|TIMESTAMP|2012.06.13T13:30:10.008|POSIXct|2012-06-13 13:30:10|
|NANOTIME|13:30:10.008007006|POSIXct|1970-01-01 13:30:10|指定为1970.01.01那天的该时刻
|NANOTIMESTAMP|2012.06.13T13:30:10.008007006|POSIXct|2012-06-13 13:30:10|
|FLOAT|2.1f|Numeric|2.1|
|DOUBLE|2.1|Numeric|2.1|
|STRING|"123"|Character|"123"|