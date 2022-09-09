#!/bin/bash
echo "修改bc1.yml的默认配置,7节点改为4节点"
chainmaker_path="/home/projects/test/chainmaker-go"
chainmaker_version="v2.3.0_alpha"
#!/bin/sh
ip_node1="172.21.48.7"
ip_node2="172.21.48.3"
ip_node3="172.21.48.12"
ip_node4="172.21.48.4"
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
# 注释bc1中7节点里最后3个节点的配置
path="${chainmaker_path}/chainmaker-${chainmaker_version}-wx-${org}.chainmaker.org/config/wx-${org}.chainmaker.org/"
cd ${path}
num=$(sed -n '/org_id: "wx-org5.chainmaker.org/=' chainconfig/bc1.yml)

array=($num)
# echo ${num}|wc -L
for line in ${array[@]}
do
	# echo "替换起始"$line
	int=$line
	while(( $int<=$line+8 ))
	do
    		echo "注释:" $int
    		sed -i "$int s/^/#&/" chainconfig/bc1.yml
    		let "int++"
	done	

done

