chainmaker_path="../../chainmaker-go"
chainmaker_version="v2.3.0_alpha"
# 获取当前ip 判断是节点几
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
pwd

pool_config(){
	echo "----------chainmaker.yml pool config---------------"
	line_num=$(sed -n '/pool_type/=' chainmaker.yml)
	# echo $num
	cat chainmaker.yml | tail -n +${line_num} | head -n 30 |grep -v "^$" |grep -v "# "
}
ip_config(){
	echo "-----------chainmaker.yml ip config----------------"
	cat chainmaker.yml | grep "1130"
}
block_config(){
	echo "------------bc1.yml block config-------------------"
	line_num=$(sed -n '/block:/=' chainconfig/bc1.yml)
	# echo $num
	cat chainconfig/bc1.yml | tail -n +$line_num | head -n 20 |grep -v "^$" |grep -v "# "
}
monitor_config(){
	echo "-------------chainmaker.yml monitor/pprof/ config---------"
	line_num=$(sed -n '/monitor/=' chainmaker.yml)
	cat chainmaker.yml | tail -n +$line_num | head -n 8 |grep -v "^$" |grep -v "# "
	line_num=$(sed -n '/pprof:/=' chainmaker.yml)
	cat chainmaker.yml | tail -n +$line_num | head -n 8 |grep -v "^$" |grep -v "# "	
}
state_cache_config(){
	echo "-------------chainmaker.yml state_cache_config------------"
	line_num=$(sed -n '/state_cache_config/=' chainmaker.yml)
	cat chainmaker.yml | tail -n +$line_num | head -n 10 |grep -v "^$" |grep -v "# "
}
consensus_type_config(){
	echo "-------------bc1.yml consensus_type_config---------------"
	line_num=$(sed -n '/consensus:/=' chainconfig/bc1.yml)
	cat chainconfig/bc1.yml |grep "auth_type:"
	cat chainconfig/bc1.yml | tail -n +$line_num | head -n 5 |grep -v "^$"
}
key_type(){
	echo "---------------key--------------------------------------"
	if [ "$auth_type" == 1 ] || [ "$auth_type" == 3 ];then
		cat certs/node/consensus1/consensus1.sign.key
	elif [ "$auth_type" == 2 ];then
		cat node${num}.key
	fi
}
tx_filter_config(){
	echo "---------------tx_filter--------------------------------------"
	line_num=$(sed -n '/tx_filter:/=' chainmaker.yml)
	cat chainmaker.yml | tail -n +$line_num | head -n 80 |grep -v "^$" |grep -v "# "
}
consensus_type_config
pool_config
ip_config
block_config
state_cache_config
monitor_config
tx_filter_config
key_type
