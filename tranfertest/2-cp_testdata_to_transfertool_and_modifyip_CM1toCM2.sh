echo  "如果是从chainmaker1.x迁移到2.x,需要配置连接chainmaker1.x的证书:"
transfertool_path="/home/projects/test/chainmaker-transfer-tool"
origin_chainmaker_path="/home/projects/online/chainmaker-go"
echo "迁移工具目录:${transfertool_path},源链目录:${origin_chainmaker_path}"
read -p " 注意这个脚本使用的是绝对路径,适用于源链和目标链在同一台host的情况:"
echo "先更新源链(CM1)上cmc下的证书"
cd /home/projects/online/my_shell
./update_and_build_cmc.sh
cd $transfertool_path
pwd
echo "更把cmc下testdata的东西复制过来"
cp -rf $origin_chainmaker_path/tools/cmc/testdata ./
echo "查看testdata是否已经更新,并且跟1.x上的一致"
ls -al $transfertool_path/testdata
echo "迁移工具连接1.x的证书"
cat $transfertool_path/testdata/crypto-config/wx-org1.chainmaker.org/node/consensus1/consensus1.nodeid
echo "1.x链上的节点证书:"
cat $origin_chainmaker_path/build/release/chainmaker-v*-wx-org1.chainmaker.org/config/wx-org1.chainmaker.org/certs/node/consensus1/consensus1.nodeid


