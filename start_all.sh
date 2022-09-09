cd ../chainmaker-go/scripts
cat cluster_quick_start.sh |grep "prepare"
read -p "该操作会覆盖节点当前的配置,如果要保留配置,请注释cluster_quick_start.sh中的prepare:"
#cd ../chainmaker-go/scripts
./cluster_quick_start.sh normal
sleep 2
ps -ef |grep "chainmaker"
netstat -ltnp |grep 1230
