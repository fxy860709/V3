echo "中断迁移工具测试,复制迁移好的数据到chainmaker-go 的node1目录下,其他节点保留之前同步的数据"
chainmaker_path="/home/projects/test/chainmaker-go/build/release"
cd "${chainmaker_path}/chainmaker-v2.2.0_alpha-node1/"
rm -rf data/*
cp -r /home/projects/test/data/node1 ./data/
#rm -rf ${chainmaker_path}/chainmaker-v2.2.0_alpha-node2/data/*
#rm -rf ${chainmaker_path}/chainmaker-v2.2.0_alpha-node3/data/*
#rm -rf ${chainmaker_path}/chainmaker-v2.2.0_alpha-node4/data/*
echo "------------node1 data -------------------"
ls -al ${chainmaker_path}/chainmaker-v2.2.0_alpha-node1/data/
echo "------------node2 data -------------------"
ls -al ${chainmaker_path}/chainmaker-v2.2.0_alpha-node2/data/
echo "------------node3 data -------------------"
ls -al ${chainmaker_path}/chainmaker-v2.2.0_alpha-node3/data/
echo "------------node4 data -------------------"
ls -al ${chainmaker_path}/chainmaker-v2.2.0_alpha-node4/data/
