#根据ip配置节点的组织名称
ip_node1="172.21.32.11"
ip_node2="172.21.32.5"
ip_node3="172.21.32.7"
ip_node4="172.21.32.6"
ip=`ifconfig -a|grep inet|grep -v 127.0.0.1|grep -v inet6|awk '{print $2}'`
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
echo "ca证书"
md5sum ../../chainmaker-go/chainmaker-*-wx-${org}.chainmaker.org/config/wx-${org}.chainmaker.org/certs/ca/wx-${org}.chainmaker.org/ca.crt
echo "共识节点证书"
md5sum ../../chainmaker-go/chainmaker-*-wx-${org}.chainmaker.org/config/wx-${org}.chainmaker.org/certs/node/consensus1/consensus1.sign.crt
echo "admin证书"
md5sum ../../chainmaker-go/chainmaker-*-wx-${org}.chainmaker.org/config/wx-${org}.chainmaker.org/certs/user/admin1/admin1.sign.crt
