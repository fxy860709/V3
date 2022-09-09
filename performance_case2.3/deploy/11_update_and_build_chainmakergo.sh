# update and build chainmaker_go

# 更新和编译cryptogen
crypto_path='../../../chainmaker-cryptogen/'
crypto_version='develop'
chainmakergo_path='../chainmaker-go/'
chainmakergo_version='v2.3.0_qc_cs_raft'
node_cnt=$1
node_cnt_default=4
chain_cnt=$2
chain_cnt_default=1
auth_type=$3
# params for prepare input
consensus_type=$4 # (1-TBFT(default),3-MAXBFT,4-RAFT)
log_level=$5 #(DEBUG|INFO(default)|WARN|ERROR)
enable_vm=$6 #(YES|NO(default))i
hash_type=$7 #(SHA256(default)|SM3):
vm_transport_prot=$8 # (uds|tcp(default))
vm_log_level=$9 # (DEBUG|INFO(default)|WARN|ERROR):

if [ -z "$auth_type" ];then
        read -p "输入身份模式(1-cert,2-pk,3-pwk): " at
        auth_type=$at
fi
if [ -z "$node_cnt" ];then
        node_cnt=$node_cnt_default
else
        node_cnt=$1
fi
if [ -z "$chain_cnt" ];then
        chain_cnt=$chain_cnt_default
else
        chain_cnt=$2
fi
echo "本次chainmakergo分支名称:${chainmakergo_version}"
#read -p "输入身份模式(1-cert,2-pk,3-pwk): " auth_type
echo '------------------更新和编译cryptogen------------------'
cd ${crypto_path}
pwd
git pull
echo "---------------------------------"
git branch
git checkout ${crypto_version}
echo "---------------------------------"
#git log --since="2022-09-01"
make
# 更新chainmakergo
echo '------------------更新chainmaker-go------------------'
cd ${chainmakergo_path}
pwd
git stash
git pull
echo "---------------------------------"
git branch
git checkout ${chainmakergo_version}
echo "---------------------------------"
if [ -L './tools/chainmaker-cryptogen' ];then
	echo '已经创建cryptogen软链接'
else
	ln -s ../../chainmaker-cryptogen/ ./tools
fi
# 执行prepare并生成安装包
echo "---------------------------------"
echo "执行prepare.sh $node_cnt $chain_cnt"
cd scripts
if [ $auth_type == 1 ];then
	/usr/bin/expect <<-EOF
set timeout 200
spawn sh prepare.sh $node_cnt $chain_cnt
expect {
"*input consensus type*" { send "$consensus_type\r"; exp_continue }
"*input log level*" { send "$log_level\r"; exp_continue }
"*enable vm go*" { send "$enable_vm\r"; exp_continue }
"*input hash type*" { send "$hash_type\r"; exp_continue }
"*vm go transport protocol*" { send "$vm_transport_prot\r"; exp_continue }
"*input vm go log level*" { send "$vm_log_level\r" }
}
expect eof
EOF
elif [ $auth_type == 2 ];then
        /usr/bin/expect <<-EOF
set timeout 200
spawn sh prepare_pk.sh $node_cnt $chain_cnt
expect {
"*input consensus type*" { send "$consensus_type\r"; exp_continue }
"*input log level*" { send "$log_level\r"; exp_continue }
"*enable vm go*" { send "$enable_vm\r"; exp_continue }
"*input hash type*" { send "$hash_type\r"; exp_continue }
"*vm go transport protocol*" { send "$vm_transport_prot\r"; exp_continue }
"*input vm go log level*" { send "$vm_log_level\r" }

}
expect eof
EOF
elif [ $auth_type == 3 ];then
        /usr/bin/expect <<-EOF
set timeout 200
spawn sh prepare_pwk.sh $node_cnt $chain_cnt
expect {
"*input consensus type*" { send "$consensus_type\r"; exp_continue }
"*input log level*" { send "$log_level\r"; exp_continue }
"*enable vm go*" { send "$enable_vm\r"; exp_continue }
"*input hash type*" { send "$hash_type\r"; exp_continue }
"*vm go transport protocol*" { send "$vm_transport_prot\r"; exp_continue }
"*input vm go log level*" { send "$vm_log_level\r" }

}
expect eof
EOF
fi

echo '开始build_release'
sh build_release.sh
echo 'start chainmaker-go'
sh cluster_quick_start.sh normal
echo "进程状态"
sleep 3
ps -ef|grep chainmaker | grep -v grep
netstat -lptn | grep 1230
