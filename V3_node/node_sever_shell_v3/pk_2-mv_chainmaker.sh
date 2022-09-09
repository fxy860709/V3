#!/bin/bash
chainmaker_path="/home/projects/test/chainmaker-go"
chainmaker_version="v2.3.0_alpha"
#根据ip配置节点的组织名称
ip_node1="172.21.48.7"
ip_node2="172.21.48.3"
ip_node3="172.21.48.12"
ip_node4="172.21.48.4"
ip=`ifconfig -a|grep inet|grep -v 127.0.0.1|grep -v inet6|awk '{print $2}'`
echo $ip
org="node1"
if [[ $ip =~ $ip_node1 ]];then
        org="node1"
elif [[ $ip =~ $ip_node2 ]];then
        org="node2"
elif [[ $ip =~ $ip_node3 ]];then
        org="node3"
elif [[ $ip =~ $ip_node4 ]];then
        org="node4"
fi
echo $org
pwd
ls -al
chainmaker_node_path="${chainmaker_path}/chainmaker-${chainmaker_version}-${org}"
echo "执行这一步前要手动确认已经备份并删除${chainmaker_node_path}"
read -p "请确认是否[直接删除]${chainmaker_node_path} 0-是,1-否:" number  #提示用户输入数字
echo $number | grep -q '[^0-9]'
n1=$?
echo $n1
if [ -z $number ];then             #判断用户是否输入，如果未输入则打印error
  echo "Error,please input!"
  exit
elif [ $n1 -eq 0 ];then
        echo "this is not a num,please input num"
        exit
fi
echo "确认结果:"$number
pwd
# /home/projects/test/my_shell_v3/node_sever_shell_v3
cd ../../chainmaker-go
if [ $number == 0 ];then
        rm -rf ${chainmaker_node_path}
	#rm -f ${chainmaker_path}/*.gz
        echo "########## tar x #############"
        cd ${chainmaker_path}
        #cp /home/fxy/chainmaker-${chainmaker_version}-wx-${org}*x86_64.tar.gz ./
	pwd
	ls -al
	tar zxvf chainmaker-${chainmaker_version}-${org}*x86_64.tar.gz 
else
        exit
fi


