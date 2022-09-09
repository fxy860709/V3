# 选择模式
auth_type=$1
pool_type=$2

if [ -z "$auth_type" ];then
        read -p "输入身份模式(1-cert,2-pk,3-pwk): " at
        auth_type=$at
fi
if [ -z "$pool_type" ];then
        read -p "请输入交易池类型(single, normal, batch): " pt
        pool_type=$pt
fi
file_path="../../../chainmaker-go/build/release"
cd ${file_path}
pwd
# 配置节点目录
if [ "$auth_type" == 1 ];then
	node_path="/home/projects/test_cert"
elif [ "$auth_type" == 2 ];then
	node_path="/home/projects/test_pk"
elif [ "$auth_type" == 3 ];then
	node_path="/home/projects/test_pwk"
fi
script_path="${node_path}/my_shell_v3/node_sever_shell_v3"
echo ${script_path}
ansible all -m shell -a "sh ${script_path}/3-update_chainmakeryml_setIP_and_7to4.sh $auth_type chdir=${script_path}"
ansible all -m shell -a "sh ${script_path}/4-update_chainmakeryml_batch_txpool.sh $auth_type $pool_type chdir=${script_path}"
ansible all -m shell -a "sh ${script_path}/6-update_bc1_blockconfig.sh $auth_type chdir=${script_path}"
ansible all -m shell -a "sh ${script_path}/7-enable_monitor.sh $auth_type chdir=${script_path}"

