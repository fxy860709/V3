cd ../chainmaker-go/scripts/
./cluster_quick_stop.sh
sleep 3
ps -ef|grep chainmaker | grep -v grep
netstat -lptn | grep 1230
