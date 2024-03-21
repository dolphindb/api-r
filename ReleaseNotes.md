# Release Notes

## 2.00.11.0

### Bug Fixes

- Fixed connection failure on Windows.
- Fixed incorrect display of null values for columns with data types CHAR and SHORT during queries.
- Fixed the issue where STRING data from DolphinDB is converted into factor type instead of character type in R during table queries.
- Fixed the error that occurred when reading tables with only one column.
- Fixed the overflow issue when downloading matrices of NANOTIMESTAMP type on Windows.