read -p "请输入要stop的节点org: (1=org1,2=org2,3=org3,4=org4):" num
i=1
version="V1.0.0"
echo ${num}
cd ../chainmaker-go/build/release/chainmaker-${version}-wx-org${num}.chainmaker.org/bin
#declare -i i=1
while ((i<=100))
do
	echo $i
	./stop.sh
	./start.sh
	let i++
done
#echo $i
#read -p "请输入要stop的节点org: (1=org1,2=org2,3=org3,4=org4):" num
#echo ${num}
#cd ../chainmaker-go/build/release/chainmaker-${version}-wx-org${num}.chainmaker.org/bin
#sleep 1
#ps -ef |grep "chainmaker"
#netstat -ltnp |grep 1230
