# 选择模式
auth_type=$1
if [ -z "$auth_type" ];then
        read -p "输入身份模式(1-cert,2-pk,3-pwk): " at
        auth_type=$at
fi
file_path="../../../chainmaker-go/build/release"
cd ${file_path}
pwd
# 配置节点目录
if [ "$auth_type" == 1 ];then
	node_path="/home/projects/test_cert"
	tar_node1=`find . -name "chainmaker-*org1*.tar.gz" -prune`
	tar_node2=`find . -name "chainmaker-*org2*.tar.gz" -prune`
	tar_node3=`find . -name "chainmaker-*org3*.tar.gz" -prune`
	tar_node4=`find . -name "chainmaker-*org4*.tar.gz" -prune`
elif [ "$auth_type" == 2 ];then
	node_path="/home/projects/test_pk"
	tar_node1=`find . -name "chainmaker-*node1*.tar.gz" -prune`
        tar_node2=`find . -name "chainmaker-*node2*.tar.gz" -prune`
        tar_node3=`find . -name "chainmaker-*node3*.tar.gz" -prune`
        tar_node4=`find . -name "chainmaker-*node4*.tar.gz" -prune`
elif [ "$auth_type" == 3 ];then
	node_path="/home/projects/test_pwk"
        tar_node1=`find . -name "chainmaker-*org1*.tar.gz" -prune`
        tar_node2=`find . -name "chainmaker-*org2*.tar.gz" -prune`
        tar_node3=`find . -name "chainmaker-*org3*.tar.gz" -prune`
        tar_node4=`find . -name "chainmaker-*org4*.tar.gz" -prune`
fi
#  复制tar包到节点
ip_node1="172.21.48.7"
ip_node2="172.21.48.3"
ip_node3="172.21.48.12"
ip_node4="172.21.48.4"
ansible all -m shell -a "rm -rf ${node_path}/chainmaker-go/*"
ansible all -m shell -a "ls -al ${node_path}/chainmaker-go"
echo ${tar_node1}
ansible ${ip_node1} -m unarchive -a "src=${tar_node1} dest=${node_path}/chainmaker-go"
ansible ${ip_node2} -m unarchive -a "src=${tar_node2} dest=${node_path}/chainmaker-go"
ansible ${ip_node3} -m unarchive -a "src=${tar_node3} dest=${node_path}/chainmaker-go"
ansible ${ip_node4} -m unarchive -a "src=${tar_node4} dest=${node_path}/chainmaker-go"
ansible all -m shell -a "ls -al ${node_path}/chainmaker-go"
