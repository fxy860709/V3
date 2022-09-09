echo "复制chainmaker-go的bc1文件到 config_path,注意bc1必须是单节点共识"
read -p "请输入目标链的 type: (1=cert/2=pk):" type_num
transfertool_path="../../chainmaker-transfer-tool"
<<<<<<< HEAD
=======
target_chain_path="../../chainmaker-go"
>>>>>>> 28512f7c9499612d8d54483877b43dd888ae51b7
cd $transfertool_path
pwd
rm -rf config_path/dev/bc1.yml
cp ../chainmaker-go/build/release/chainmaker-v*-*1*/config/*1*/chainconfig/bc1.yml  ./config_path/dev/bc1.yml

if ((type_num==1));then
        echo "--------目标链为cert模式,删除config_path下的org1--------"
	rm -rf config_path/wx-org1.chainmaker.org/
	echo "复制org1的配置文件到config_path下"
	cp -r ../chainmaker-go/build/release/chainmaker-v*-*1*/config/wx-org1.chainmaker.org ./config_path/
	echo "-------------------trustroot目录替换为当前目录------------------------"
        sed -i 's/..\/config\/wx-org1/.\/config_path\/wx-org1/g' ./config_path/dev/bc1.yml
elif ((type_num==2));then
	echo "--------目标链为public模式,删除config_path下的node1-----"
	rm -rf config_path/node1/
	echo "复制node1的配置文件到config_path下"
	cp -r ../chainmaker-go/build/release/chainmaker-*-node1/config/node1 ./config_path/
	echo "-------------------trustroot目录替换为当前目录------------------------"
	sed -i 's/..\/config\/node1/.\/config_path\/node1/g' ./config_path/dev/bc1.yml
else
	echo "ERROR chaintype type_num=$type_num"
fi
echo "--------------------查看当前config_path下的node1是否为最新------------"
ls -al ./config_path
echo "--------------------查看bc1是否已经替换-------------------------------"
ls -al ./config_path/dev
echo "--------------------查看dev下bc1中的trust_root的路径是否修改----------"
cat ./config_path/dev/bc1.yml | grep "-"
cat ./config_path/dev/config.yml |grep "consensus_id"
