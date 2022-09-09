echo "复制迁移好的数据到chainmaker-go 的node1目录下"
chainmaker_path="../../chainmaker-go/build/release"
read -p "请输入目标链的 type: (1=cert/2=pk):" type_num
cd ${chainmaker_path}/chainmaker-v*-*1*/
pwd
if ((type_num==1));then
	echo "cert模式,将迁移后的data目录下node1重命名为wx-org1.chainmaker.org,并复制到org1的目录下"
	cp -r ../../../../data/node1 ../../../../data/wx-org1.chainmaker.org
	echo "迁移后的data目录:"
	ls  ../../../../data
	echo "删除目标链的data目录:"
	rm -rf data/*
	pwd
	ls -al ./data
	echo "复制迁移数据到目标链data目录下:"
	cp -r ../../../../data/* ./data/
	ls -al ./data/
elif ((type_num==2));then
	echo "pk模式,将迁移后的data目录下wx-org1.chainmaker.org复制到node1"
	cp -r ../../../../data/wx-org1.chainmaker.org ../../../../data/node1
	rm -rf data/*
	ls -al data/
	cp -r ../../../../data/* ./data/
	ls -al data/
else
	echo "ERROR chaintype type_num=$type_num"
fi
current_path=$(pwd)
echo $current_path
#cp -r /home/projects/test/data/node1 ./data/
echo "清除其他节点的数据:"
rm -rf ../chainmaker-v*-*2*/data/*
rm -rf ../chainmaker-v*-*3*/data/*
rm -rf ../chainmaker-v*-*4*/data/*
echo "清除完成"
echo "------------node1 data -------------------"
ls -al ../chainmaker-v*-*1*/data/
echo "------------node2 data -------------------"
ls -al ../chainmaker-v*-*2*/data/
echo "------------node3 data -------------------"
ls -al ../chainmaker-v*-*3*/data/
echo "------------node4 data -------------------"
ls -al ../chainmaker-v*-*4*/data/
