#!/bin/bash
echo "修改chainmaker.yml的默认交易池配置:改为批量交易池并设置大小"
#!/bin/sh
ip_node1="172.21.32.11"
ip_node2="172.21.32.5"
ip_node3="172.21.32.7"
ip_node4="172.21.32.6"
ip=`ifconfig -a|grep inet|grep -v 127.0.0.1|grep -v inet6|awk '{print $2}'|tr -d "addr:"​`
echo $ip
org="org1"
if [[ $ip =~ $ip_node1 ]];then
        org="org1"
elif [[ $ip =~ $ip_node2 ]];then
        org="org2"
elif [[ $ip =~ $ip_node3 ]];then
        org="org3"
elif [[ $ip =~ $ip_node4 ]];then
        org="org4"
fi
echo $org
# 修改配置文件 中批量交易池的大小
path="/mnt/datadisk0/chainmaker/chainmaker-wx-${org}.chainmaker.org.consensus/config/wx-${org}.chainmaker.org/"
cd ${path}

sed -i 's/#  pool_type:/  pool_type:/g' chainmaker.yml
sed -i 's/#  batch_max_size: 30000/  batch_max_size: 10000/g' chainmaker.yml
sed -i 's/#  batch_create_timeout: 200/  batch_create_timeout: 10000/g' chainmaker.yml
sed -i 's/max_txpool_size: 50000/max_txpool_size: 500000/g' chainmaker.yml

