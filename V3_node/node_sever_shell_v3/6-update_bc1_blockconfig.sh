#!/bin/bash
chainmaker_path="../../chainmaker-go"
chainmaker_version="v2.3.0_alpha"
echo "修改bc1.yml块配置:交易时间戳过期,块最大交易数,块最大MB,出块间隔"
tx_timeout=600 # Transaction timeout, in second.
block_tx_capacity=10000 # Max transaction count in a block.
block_size=10 #Max block size, in MB
block_interval=10 # The interval of block proposing attempts, in millisecond
# 获取本机ip确定是node几
ip_node1="172.21.48.7"
ip_node2="172.21.48.3"
ip_node3="172.21.48.12"
ip_node4="172.21.48.4"
ip=`ifconfig -a|grep inet|grep -v 127.0.0.1|grep -v inet6|awk '{print $2}'|tr -d "addr:"`
echo $ip
num="1"
org="org${num}"
if [[ $ip =~ $ip_node1 ]];then
        num="1"
elif [[ $ip =~ $ip_node2 ]];then
        num="2"
elif [[ $ip =~ $ip_node3 ]];then
        num="3"
elif [[ $ip =~ $ip_node4 ]];then
        num="4"
fi
echo $org
# 获取身份模式
auth_type=$1
if [ -z "$auth_type" ];then
        read -p "输入身份模式(1-cert,2-pk,3-pwk): " at
        auth_type=$at
fi
if [ "$auth_type" == 1 ] || [ "$auth_type" == 3 ];then
        path="${chainmaker_path}/chainmaker-${chainmaker_version}-wx-org${num}.chainmaker.org/config/wx-org${num}.chainmaker.org/"
elif [ "$auth_type" == 2 ];then
        path="${chainmaker_path}/chainmaker-${chainmaker_version}-node${num}/config/node${num}/"
fi
cd ${path}
echo "修改bc1中块大小相关配置:"
pwd
sed -i "s/tx_timeout: \b[0-9]\+/tx_timeout: ${tx_timeout}/g" chainconfig/bc1.yml
sed -i "s/block_tx_capacity: \b[0-9]\+/block_tx_capacity: ${block_tx_capacity}/g" chainconfig/bc1.yml
sed -i "s/block_size: \b[0-9]\+/block_size: ${block_size}/g" chainconfig/bc1.yml
sed -i "s/block_interval: \b[0-9]\+/block_interval: ${block_interval}/g" chainconfig/bc1.yml

num=$(sed -n '/block:/=' chainconfig/bc1.yml)
#num=$(($num+2))
cat chainconfig/bc1.yml | tail -n +$num | head -n 20 |grep -v "# "
