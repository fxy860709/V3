#!/bin/bash
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
echo "修改日志配置文件中的core的log等级:"
level="INFO"
read -p "core log evel(1-INFO,2-DEBUG,3-ERROR,default=1: " number  #提示用户输入数字
if [ -z $number ];then             #判断用户是否输入，如果未输入则打印error
  echo "Error"
  exit
else
  result=`echo "$number*1" | bc `  #把用户的输入值和1相乘，交给bc做运算
  if [ $result -eq 0 ];then          #判断计算结果是否为0，为0则说明number非数字(字符串和0相乘结果为0)
   echo ""
   exit
  fi
  if [ $number == 1 ];then
	level="INFO"
  elif [ $number == 2 ];then
	level="DEBUG"
  elif [ $number == 3 ];then
	level="ERROR"
  fi
  echo "日志级别选择:"$level
fi
cd /mnt/datadisk0/chainmaker/chainmaker-wx-${org}.chainmaker.org.consensus/config/wx-${org}.chainmaker.org
sed -i "s/core: ERROR/core: ${level}/g" log.yml
sed -i "s/core: DEBUG/core: ${level}/g" log.yml
sed -i "s/core: INFO/core: ${level}/g" log.yml

