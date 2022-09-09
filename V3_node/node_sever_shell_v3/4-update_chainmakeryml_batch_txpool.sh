#!/bin/bash
chainmaker_path="../../chainmaker-go"
chainmaker_version="v2.3.0_alpha"
# 获取本机ip确定是node几
ip_node1="172.21.48.7"
ip_node2="172.21.48.3"
ip_node3="172.21.48.12"
ip_node4="172.21.48.4"
ip=`ifconfig -a|grep inet|grep -v 127.0.0.1|grep -v inet6|awk '{print $2}'|tr -d "addr:"​`
echo $ip
num="1"
if [[ $ip =~ $ip_node1 ]];then
        num="1"
elif [[ $ip =~ $ip_node2 ]];then
        num="2"
elif [[ $ip =~ $ip_node3 ]];then
        num="3"
elif [[ $ip =~ $ip_node4 ]];then
        num="4"
fi
org="org${num}"
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
# 修改配置文件中批量交易池的大小
pwd
echo "修改chainmaker.yml的默认交易池配置:改为批量交易池并设置大小"
pool_type=$2
if [ -z "$pool_type" ];then
        read -p "请输入交易池类型(single, normal, batch): " pt
        pool_type=$pt
fi
#read -p "$pool_type"
if [ "$pool_type" = "normal" ];then
	echo "########## normal交易池配置最优配置  ###############"
	#pool_type="normal" # single, normal, batch
	max_txpool_size="500000" # 500000 Max common transaction count in tx_pool.
	batch_max_size=50 #50 The number of transactions contained in a batch, for normal and batch tx_pool.
	batch_create_timeout=10 #10 Interval of creating a transaction batch, for normal and batch tx_pool, in millisecond(ms).
	# 以下几项保持默认值
	is_dump_txs_in_queue=true
	max_config_txpool_size=10
	common_queue_num=8
elif [ "$pool_type" = "batch" ];then
	echo "########## batch交易池配置最优配置  ###############"
	#pool_type="batch" # single, normal, batch
        max_txpool_size="500000" # 500000
        batch_max_size=2000 #50
        batch_create_timeout=500 #10
        # 以下几项保持默认值
        is_dump_txs_in_queue=true
        max_config_txpool_size=10
        common_queue_num=8
elif [ "$pool_type" = "single" ];then
        echo "########## single交易池配置最优配置  ###############"
        #pool_type="single" # single, normal, batch
        max_txpool_size="500000" # 500000
        batch_max_size=50 #不生效
        batch_create_timeout=10 #不生效
        # 以下几项保持默认值
        is_dump_txs_in_queue=true
        max_config_txpool_size=10 
        common_queue_num=8 #不生效
fi
#sed -i "s/pool_type: \W\+[0-9]\+\W\+/pool_type: \"${pool_type}\"/g" chainmaker.yml
sed -i "s/pool_type: \W\+[a-z]\+\W\+/pool_type: \"${pool_type}\"/g" chainmaker.yml
#sed -i "s/max_txpool_size: /max_txpool_size: ${max_txpool_size}/g" chainmaker.yml
sed -i "s/max_txpool_size: \b[0-9]\+/max_txpool_size: ${max_txpool_size}/g" chainmaker.yml
#sed -i "s/batch_max_size: /batch_max_size: ${batch_max_size}/g" chainmaker.yml
sed -i "s/batch_max_size: \b[0-9]\+/batch_max_size: ${batch_max_size}/g" chainmaker.yml
#sed -i "s/batch_create_timeout: /batch_create_timeout: ${batch_create_timeout}/g" chainmaker.yml
sed -i "s/batch_create_timeout: \b[0-9]\+/batch_create_timeout: ${batch_create_timeout}/g" chainmaker.yml
num=$(sed -n '/pool_type/=' chainmaker.yml)
echo $num
#array=($num)
cat chainmaker.yml | tail -n +${num} | head -n 30 |grep -v "# "
