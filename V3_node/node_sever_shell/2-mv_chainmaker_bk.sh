#!/bin/bash


#根据ip配置节点的组织名称
ip_node1="172.21.32.11"
ip_node2="172.21.32.5"
ip_node3="172.21.32.7"
ip_node4="172.21.32.6"
ip=`ifconfig -a|grep inet|grep -v 127.0.0.1|grep -v inet6|awk '{print $2}'|tr -d "addr:"<200b>`
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

echo "执行这一步前要手动确认已经备份并删除/mnt/datadisk0/chainmaker/chainmaker-wx-${org}.chainmaker.org.consensus"
echo "########## tar x #############"
# tar zxvf /home/fxy/chainmaker-v2.0.0-wx-${org}.chainmaker.org-20210826172006-x86_64.tar.gz -C /mnt/datadisk0/chainmaker/
ls *x86_64.tar.gz | xargs -n1 tar xzvf
echo "########## mv ################"
mv /mnt/datadisk0/chainmaker/chainmaker-v2.0.0-wx-${org}.chainmaker.org /mnt/datadisk0/chainmaker/chainmaker-wx-${org}.chainmaker.org.consensus

