# update and build chainmaker_go

# 更新和编译cryptogen
crypto_path='../chainmaker-cryptogen/'
crypto_version='develop'
chainmakergo_path='../chainmaker-go/'
chainmakergo_version='v2.3.0_alpha'
node_cnt=$1
node_cnt_default=4
chain_cnt=$2
chain_cnt_default=1
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

#<<!
echo '------------------更新和编译cryptogen------------------'
cd ${crypto_path}
pwd
#git stash
git pull
echo "---------------------------------"
git branch
git checkout ${crypto_version}
echo "---------------------------------"
#git log
git log --since="2022-01-01"
make
# cat config/pkcs11_keys.yml
# 更新chainmakergo
echo '------------------更新chainmaker-go------------------'
cd ${chainmakergo_path}
pwd
git stash
git pull
echo "---------------------------------"
git branch
git checkout ${chainmakergo_version}
git log --since="2022-01-01"
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
sh prepare_pk.sh $node_cnt $chain_cnt
echo '开始build_release'
sh build_release.sh
echo 'start chainmaker-go'
sh cluster_quick_start.sh normal
echo "进程状态"
sleep 3
ps -ef|grep chainmaker | grep -v grep
netstat -lptn | grep 1230
