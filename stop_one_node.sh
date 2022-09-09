read -p "请输入要stop的节点org: (1=org1,2=org2,3=org3,4=org4):" num
echo ${num}
cd ../chainmaker-go/build/release/chainmaker-*${num}*/bin
./stop.sh
sleep 2
ps -ef |grep "chainmaker"
netstat -ltnp |grep 1230
