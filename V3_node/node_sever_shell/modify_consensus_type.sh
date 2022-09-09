#!/bin/bash
echo "修改配置文件中的共识算法:共识类型(0-SOLO,1-TBFT,2-MBFT,3-HOTSTUFF,4-RAFT,5-DPOS,10-POW)"
#!/bin/sh
ip_node1="172.21.32.11"
ip_node2="172.21.32.5"
ip_node3="172.21.32.7"
ip_node4="172.21.32.6"
ip=`ifconfig -a|grep inet|grep -v 127.0.0.1|grep -v inet6|awk '{print $2}'|tr -d "addr:"​`
echo $ip
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
bc_path="/mnt/datadisk0/chainmaker/chainmaker-wx-${org}.chainmaker.org.consensus/config/wx-${org}.chainmaker.org/chainconfig"
chainmaker_path="/mnt/datadisk0/chainmaker/chainmaker-wx-${org}.chainmaker.org.consensus/config/wx-${org}.chainmaker.org"
read -p "consensus type: " number  #提示用户输入数字
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
cd $bc_path
sed -i "s/ type: 0/ type: ${number}/g" bc1.yml
sed -i "s/ type: 1/ type: ${number}/g" bc1.yml
sed -i "s/ type: 2/ type: ${number}/g" bc1.yml
sed -i "s/ type: 3/ type: ${number}/g" bc1.yml
sed -i "s/ type: 4/ type: ${number}/g" bc1.yml
sed -i "s/ type: 5/ type: ${number}/g" bc1.yml
sed -i "s/ type: 6/ type: ${number}/g" bc1.yml
sed -i "s/ type: 5/ type: ${number}/g" bc1.yml
sed -i "s/ type: 6/ type: ${number}/g" bc1.yml
# 判断共识算法是否为solo
if [ $number == 0 ];then
	echo "共识算法为solo,修改原本是4节点的配置文件,共识配置consensus.nodes保留node1:"
	cd $bc_path
	# 先备份非solo的配置,方便从solo变为其他配置时可以手动恢复
	cp -r bc1.yml bc1_notsolo.yml
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
	cd $chainmaker_path
	cp -r chainmaker.yml chainmaker_notsolo.yml
#	sed -i 's/\- \"\/ip4\/172.21.32.11\/tcp\/11301\/p2p\/Qm/\# \- \"\/ip4\/172.21.32.11\/tcp\/11301\/p2p\/Qm/g' chainmaker.yml
	sed -i 's/\- \"\/ip4\/172.21.32.5\/tcp\/11302\/p2p\/Qm/\# \- \"\/ip4\/172.21.32.5\/tcp\/11302\/p2p\/Qm/g' chainmaker.yml
	sed -i 's/\- \"\/ip4\/172.21.32.7\/tcp\/11303\/p2p\/Qm/\# \- \"\/ip4\/172.21.32.7\/tcp\/11303\/p2p\/Qm/g' chainmaker.yml
	sed -i 's/\- \"\/ip4\/172.21.32.6\/tcp\/11304\/p2p\/Qm/\# \- \"\/ip4\/172.21.32.6\/tcp\/11304\/p2p\/Qm/g' chainmaker.yml
	sed -i 's/#  pool_type:/  pool_type:/g' chainmaker.yml
	sed -i 's/#  batch_max_size: /  batch_max_size: /g' chainmaker.yml
	sed -i 's/#  batch_create_timeout: /  batch_create_timeout: /g' chainmaker.yml
fi
# 如果是hotstuff 不支持批量交易池配置
if [ $number == 3 ];then
	cd $chainmaker_path
	cp -r chainmaker.yml chainmaker_withbatch.yml
	sed -i 's/  pool_type:/#  pool_type:/g' chainmaker.yml
	sed -i 's/  batch_max_size: /#  batch_max_size: /g' chainmaker.yml
	sed -i 's/  batch_create_timeout: /#  batch_create_timeout: /g' chainmaker.yml
fi
	
: << !
cd /mnt/datadisk0/chainmaker/chainmaker-wx-org1.chainmaker.org.consensus/config/wx-org1.chainmaker.org/chainconfig
sed -i 's/ type: 0/ type: number/g' bc1.yml
sed -i 's/ type: 1/ type: number/g' bc1.yml
sed -i 's/ type: 2/ type: number/g' bc1.yml
sed -i 's/ type: 3/ type: number/g' bc1.yml
sed -i 's/ type: 4/ type: number/g' bc1.yml
sed -i 's/ type: 5/ type: number/g' bc1.yml
sed -i 's/ type: 6/ type: number/g' bc1.yml
sed -i 's/ type: 5/ type: number/g' bc1.yml
sed -i 's/ type: 6/ type: number/g' bc1.yml
!
