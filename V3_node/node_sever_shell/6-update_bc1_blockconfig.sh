#!/bin/bash
echo "修改bc1.yml块配置:交易时间戳过期,块最大交易数,块最大MB,出块间隔"
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
# 注释修改bc1中块大小相关配置
path="/mnt/datadisk0/chainmaker/chainmaker-wx-${org}.chainmaker.org.consensus/config/wx-${org}.chainmaker.org/"
cd ${path}

sed -i 's/tx_timeout: 600 /tx_timeout: 60000 /g' chainconfig/bc1.yml
sed -i 's/block_tx_capacity: 100 /block_tx_capacity: 10000 /g' chainconfig/bc1.yml
sed -i 's/block_size: 10 /block_size: 100 /g' chainconfig/bc1.yml
sed -i 's/block_interval: 2000 /block_interval: 10 /g' chainconfig/bc1.yml
