#!/bin/bash
echo "修改chainmaker.yml的默认配置文件的ip,注释7节点配置,改为4节点配置"
#!/bin/sh
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
# chainmaker.yml中把3个节点注释,并修改配置文件中的ip
path="/mnt/datadisk0/chainmaker/chainmaker-wx-${org}.chainmaker.org.consensus/config/wx-${org}.chainmaker.org/"
cd ${path}

sed -i 's/\"\/ip4\/127.0.0.1\/tcp\/11301\/p2p\/Qm/\"\/ip4\/172.21.32.11\/tcp\/11301\/p2p\/Qm/g' chainmaker.yml
sed -i 's/\"\/ip4\/127.0.0.1\/tcp\/11302\/p2p\/Qm/\"\/ip4\/172.21.32.5\/tcp\/11302\/p2p\/Qm/g' chainmaker.yml
sed -i 's/\"\/ip4\/127.0.0.1\/tcp\/11303\/p2p\/Qm/\"\/ip4\/172.21.32.7\/tcp\/11303\/p2p\/Qm/g' chainmaker.yml
sed -i 's/\"\/ip4\/127.0.0.1\/tcp\/11304\/p2p\/Qm/\"\/ip4\/172.21.32.6\/tcp\/11304\/p2p\/Qm/g' chainmaker.yml
sed -i 's/\- \"\/ip4\/127.0.0.1\/tcp\/11305\/p2p\/Qm/\# \- \"\/ip4\/127.0.0.1\/tcp\/11305\/p2p\/Qm/g' chainmaker.yml
sed -i 's/\- \"\/ip4\/127.0.0.1\/tcp\/11306\/p2p\/Qm/\# \- \"\/ip4\/127.0.0.1\/tcp\/11306\/p2p\/Qm/g' chainmaker.yml
sed -i 's/\- \"\/ip4\/127.0.0.1\/tcp\/11307\/p2p\/Qm/\# \- \"\/ip4\/127.0.0.1\/tcp\/11307\/p2p\/Qm/g' chainmaker.yml
