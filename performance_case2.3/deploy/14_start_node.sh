# 选择模式
auth_type=$1
operation=$2

if [ -z "$auth_type" ];then
        read -p "输入身份模式(1-cert,2-pk,3-pwk): " at
        auth_type=$at
fi
if [ -z "$operation" ];then
        read -p "1-start,2-stop,3-restart,4-clear_log,5-clear_data: " op
        operation=$op
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
if [ "$operation" == 1 ];then
	ansible all -m shell -a "sh ${script_path}/start_node.sh $auth_type chdir=${script_path}"
elif [ "$operation" == 2 ];then
	ansible all -m shell -a "sh ${script_path}/stop_node.sh $auth_type chdir=${script_path}"
elif [ "$operation" == 3 ];then
	ansible all -m shell -a "sh ${script_path}/restart_node.sh $auth_type chdir=${script_path}"
elif [ "$operation" == 4 ];then
        ansible all -m shell -a "sh ${script_path}/clear_node.sh $auth_type chdir=${script_path}"
fi

