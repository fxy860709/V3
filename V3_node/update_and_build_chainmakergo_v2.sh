# update and build chainmaker_go

# 更新和编译cryptogen
crypto_path='/home/projects/chainmaker-cryptogen/'
chainmakergo_path='/home/projects/chainmaker-go/'
chainmakergo_version='v2.2.0_alpha_qc'
#<<!
echo '更新和编辑cryptogen'
cd ${crypto_path}
pwd
git pull
git branch
#git log
git log --since="2022-02-01"
make

# 更新chainmakergo
echo '更新chainmaker-go'
cd ${chainmakergo_path}
pwd
git pull
git branch
git checkout ${chainmakergo_version}
if [ -L './tools/chainmaker-cryptogen' ];then
        echo '已经创建cryptogen软链接'
else
        ln -s ../../chainmaker-cryptogen/ ./tools
fi

# 执行prepare并生成安装包
echo '执行prepare.sh 4 1'
cd scripts
sh prepare.sh 4 1
echo '开始build_release'
sh build_release.sh
echo 'start chainmaker-go'
sh cluster_quick_start.sh normal
# echo "进程状态"
# sleep 3
# ps -ef|grep chainmaker | grep -v grep
# netstat -lptn | grep 1230
