## Resintall and load package
cd api-r
Rscript InstallLocal.R


## Testing

1. cd test/

2. Modify Assert.R
modify IP address and port number based on your running DolphinDB server

ip_addr <- "38.124.1.173"
port <- 8921

3. execute run_test.sh

./run_test.sh > ROut.txt

4. Summerize result and only print failed cases
python RSummary.py ROut.txt 