isopen=$1
ip_addr=$2
num=$3
echo $isopen $ip_addr $num
#read -p "uds_open=? true/false: "  isopen
#read -p "请输入要修改的节点: (1=node1) :" num
#read -p "dockervm 的IP: " ip_addr
echo ${num}
chainmaker_path="../chainmaker-go/build/release"
path="${chainmaker_path}/chainmaker-*${num}*/config/*${num}*/"

# docker方式部署
path="/home/projects/test/chainmaker-go/scripts/docker/config/four-nodes/*${num}*"
cd ${path} 
pwd
sed -i "s%uds_open: true\+%uds_open: ${isopen}%g" chainmaker.yml 
sed -i "s%uds_open: false\+%uds_open: ${isopen}%g" chainmaker.yml

sed -i "/.*docker_vm_host.*/c\  docker_vm_host: ${ip_addr}" chainmaker.yml
#sed -i "s%docker_vm_host: 127.0.0.1\+%docker_vm_host: ${ip_addr}%g" chainmaker.yml
#sed -i "s%docker_vm_host: 127.0.0.1\+%docker_vm_host: ${ip_addr}%g" chainmaker.yml
#sed -i "s%docker_vm_host: ^[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}$\+%docker_vm_host: ${ip_addr}%g" chainmaker.yml
#echo ${num}
#vim ../chainmaker-go/build/release/chainmaker-*-node${num}/config/node${num}/chainmaker.yml
