#!/bin/bash
echo "修改bc1.yml的默认配置,7节点改为4节点"
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
echo ${path}
pwd
num=$(sed -n '/monitor/=' chainmaker.yml)
line_num=$(($num+2))
echo "monitor 配置在第${num}行"
sed -i "$line_num s/false/true/g" chainmaker.yml
cat chainmaker.yml | tail -n +$num | head -n 10 |grep -v "# "

