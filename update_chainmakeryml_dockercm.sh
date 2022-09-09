#ip_addr=$1
num=$1
#echo $ip_addr $num
if [ -z "$num" ]; then
#	read -p "请输入ip地址: (例如 172.48.1.11): "  ip_addr
	read -p "请输入节点: (例如 1): " num
fi
#read -p "请输入要修改的节点: (1=node1) :" num
#read -p "dockervm 的IP: " ip_addr
echo ${num}
chainmaker_path="../chainmaker-go/build/release"
#path="${chainmaker_path}/chainmaker-*org${num}*/config/*${num}*/"

# docker方式部署
path="/home/projects/test/chainmaker-go/scripts/docker/config/four-nodes/*${num}*"
cd ${path} 
pwd
old="/ip4/127.0.0.1/tcp/11301"
new="/ip4/172.48.1.11/tcp/11301"
echo $old $new
sed -i "s%${old}\+%${new}%g" chainmaker.yml 

old="/ip4/127.0.0.1/tcp/11302"
new="/ip4/172.48.1.12/tcp/11302"
echo $old $new
sed -i "s%${old}\+%${new}%g" chainmaker.yml 

old="/ip4/127.0.0.1/tcp/11303"
new="/ip4/172.48.1.13/tcp/11303"
echo $old $new
sed -i "s%${old}\+%${new}%g" chainmaker.yml 

old="/ip4/127.0.0.1/tcp/11304"
new="/ip4/172.48.1.14/tcp/11304"
echo $old $new
sed -i "s%${old}\+%${new}%g" chainmaker.yml 

