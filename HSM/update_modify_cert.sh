#
read -p "请输入节点号:" num
version="v2.2.0"
cert_path="../../chainmaker-go/build/release/chainmaker-${version}-wx-org${num}.chainmaker.org/config/wx-org${num}.chainmaker.org/certs"
file_path=""
read -p "请输入要修改的角色类型:
[1]consensus
[2]common
[3]admin
[4]client
[5]light
" user_type
read -p "请输入要修改的文件类型:
[1]nodeid
[2]sign.crt
[3]sign.key
[4]tls.crt
[5]tls.key
" file_type
consensus_path=${cert_path}/node/consensus1/consensus1
common_path=${cert_path}/node/common1/common1
admin_path=${cert_path}/user/admin1/admin1
client_path=${cert_path}/user/client1/client1
light_path=${cert_path}/user/light1/light1
if [ $user_type == 1 ];then
	file_path=$consensus_path
elif [ $user_type == 2 ];then
	file_path=$common_path
elif [ $user_type == 3 ];then
	file_path=$admin_path
elif [ $user_type == 4 ];then
	file_path=$client_path
elif [ $user_type == 5 ];then
	file_path=$light_path
fi
if [ $file_type == 1 ];then
	file_path=${file_path}.nodeid
elif [ $file_type == 2 ];then
	file_path=${file_path}.sign.crt
elif [ $file_type == 3 ];then
	file_path=${file_path}.sign.key
elif [ $file_type == 4 ];then
        file_path=${file_path}.tls.crt
elif [ $file_type == 5 ];then
        file_path=${file_path}.tls.key
fi
vim $file_path
