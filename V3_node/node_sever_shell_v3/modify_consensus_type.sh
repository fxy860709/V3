#!/bin/bash
echo "修改配置文件中的共识算法:共识类型(0-SOLO,1-TBFT,2-MBFT,3-HOTSTUFF,4-RAFT,5-DPOS,10-POW)"
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
echo ${path}
pwd

read -p "请选择共识类型consensus type: " number  #提示用户输入数字
echo $number | grep -q '[^0-9]'
n1=$?
# echo $n1
if [ -z $number ];then             #判断用户是否输入，如果未输入则打印error
  echo "Error,please input!"
  exit
elif [ $n1 -eq 0 ];then
        echo "this is not a num,please input num"
        exit
fi
echo "共识算法选择:"$number
# 修改bc1.yml的type:
sed -i "s/ type: \b[0-9]\+/ type: ${number}/g" chainconfig/bc1.yml
cat chainconfig/bc1.yml |grep "type"

# 判断共识算法是否为solo
if [ $number == 0 ];then
	pwd
	echo "共识算法为solo,修改原本是4节点的配置文件,共识配置consensus.nodes保留node1:"
	# 先备份非solo的配置,方便从solo变为其他配置时可以手动恢复
	cp -r chainconfig/bc1.yml chainconfig/bc1_notsolo.yml
	num=$(sed -n '/org_id: "wx-org2.chainmaker.org/=' bc1.yml)
	array=($num)
	for line in ${array[@]}
	do
		int=$line
		while(( $int<=$line+8 ))
		do
			echo "注释:" $int
			sed -i "$int s/^/#&/" bc1.yml
			let "int++"
		done
	done
	cp -r chainmaker.yml chainmaker_notsolo.yml
	sed -i 's/\- \"\/ip4\/172.21.48.7\/tcp\/11301\/p2p\/Qm/\# \- \"\/ip4\/172.21.32.11\/tcp\/11301\/p2p\/Qm/g' chainmaker.yml
	sed -i 's/\- \"\/ip4\/172.21.48.3\/tcp\/11302\/p2p\/Qm/\# \- \"\/ip4\/172.21.32.5\/tcp\/11302\/p2p\/Qm/g' chainmaker.yml
	sed -i 's/\- \"\/ip4\/172.21.48.12\/tcp\/11303\/p2p\/Qm/\# \- \"\/ip4\/172.21.32.7\/tcp\/11303\/p2p\/Qm/g' chainmaker.yml
	sed -i 's/\- \"\/ip4\/172.21.48.4\/tcp\/11304\/p2p\/Qm/\# \- \"\/ip4\/172.21.32.6\/tcp\/11304\/p2p\/Qm/g' chainmaker.yml
	sed -i 's/#  pool_type:/  pool_type:/g' chainmaker.yml
	sed -i 's/#  batch_max_size: /  batch_max_size: /g' chainmaker.yml
	sed -i 's/#  batch_create_timeout: /  batch_create_timeout: /g' chainmaker.yml
fi
# 如果是hotstuff 不支持批量交易池配置
if [ $number == 3 ];then
	pwd
	cp -r chainmaker.yml chainmaker_withbatch.yml
	sed -i 's/  pool_type:/#  pool_type:/g' chainmaker.yml
	sed -i 's/  batch_max_size: /#  batch_max_size: /g' chainmaker.yml
	sed -i 's/  batch_create_timeout: /#  batch_create_timeout: /g' chainmaker.yml
fi
	
