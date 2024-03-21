# 版本发布说明

## 2.00.11.0

### 故障修复

- 修复了 Windows 版本下 R API 无法连接 DolphinDB server 的问题
- 修复了表查询时数据类型为 CHAR 和 SHORT 的列的空值显示错误的问题。
- 修复了表查询时数据类型为 STRING 的列未能转换为 R语言的 Character 类型的问题。
- 修复了读取只有一列的表时出错的问题。
- 修复了 Windows 版本 API 下载 NANOTIMESTAMP 类型矩阵数值溢出的问题。