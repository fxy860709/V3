current_version="v2.2.1"
chainmaker_path="/home/projects/test/chainmaker-go"
cryptogen_path="/home/projects/test/chainmaker-cryptogen"

gen_new_cert(){
echo "------------在chainmaker-cryptogen下生成org5的节点证书：-------------------"
cd "${cryptogen_path}/bin"
# 备份旧文件
rm -rf crypto-config-bk
mv crypto-config crypto-config-bk
echo "复制与链相关的证书"
pwd
cp -r "${chainmaker_path}/build/crypto-config" ./
# 修改配置文件，例如增加一个共识节点，type: consensus 下面count: 本来是1，改为2就能增加一个共识节点
# 如果修改host_name: wx-org下的count, 则会增加一个新的节点
vim ../config/crypto_config_template.yml
pwd 
echo "生成新的证书"
./chainmaker-cryptogen extend -c ../config/crypto_config_template.yml
}
copy_node_file(){
echo “——————————————————复制节点包文件——————————————————”
cd "${chainmaker_path}/build/release"
cp -r "chainmaker-$current_version-wx-org1.chainmaker.org" "chainmaker-$current_version-wx-org5.chainmaker.org"
echo "把chainmaker-v2.0.0-wx-org5.chainmaker.org/bin下所有的.sh脚本中所有wx-org1.chainmaker.org替换为wx-org5.chainmaker.org"
cd chainmaker-*-wx-org5.chainmaker.org/
#cd /home/projects/test/chainmaker-go/build/release/chainmaker-V1.0.0-wx-org5.chainmaker.org/
sed -i 's/org1/org5/g' bin/start.sh
sed -i 's/org1/org5/g' bin/stop.sh
sed -i 's/org1/org5/g' bin/restart.sh
sed -i 's/org1/org5/g' bin/run.sh

echo "删除org1下的data和log"
rm -rf data/*
rm -rf log/*

echo "config/下的org1目录重命名为org5"
mv config/wx-org1.chainmaker.org config/wx-org5.chainmaker.org
pwd
}
update_cert(){
echo "使用chainmaker-cryptogen生成的wx-org5.chainmaker.org下的node和user"
echo "分别覆盖掉wx-org5.chainmaker.org/config/wx-org5.chainmaker.org/certs下的node和user"
crypto_cert=${cryptogen_path}/bin/crypto-config/wx-org5.chainmaker.org
chainmaker_cert=${chainmaker_path}/build/release/chainmaker-*-wx-org5.chainmaker.org/config/wx-org5.chainmaker.org/certs
echo $crypto_cert
echo $chainmaker_cert
ls $crypto_cert/user
ls $chainmaker_cert/user
cp -rf $crypto_cert/user $chainmaker_cert
cp -rf $crypto_cert/node $chainmaker_cert
}
update_config(){
echo "----------------修改chainmaker.yml----------------"
echo "把wx-org5.chainmaker.org/config/wx-org5.chainmaker.org/chainmaker.yml中所有wx-org1.chainmaker.org替换为wx-org5.chainmaker.org"
sed -i 's/org1/org5/g' config/wx-org5.chainmaker.org/chainmaker.yml
echo "修改net模块，把 listen_addr: /ip4/0.0.0.0/tcp/11301 修改为 listen_addr: /ip4/0.0.0.0/tcp/11305"
old_config="/ip4/0.0.0.0/tcp/11301"
new_config="/ip4/0.0.0.0/tcp/11305"
sed -i "s%${old_config}\+%${new_config}%g" config/wx-org5.chainmaker.org/chainmaker.yml
sed -i 's/12301/12305/g' config/wx-org5.chainmaker.org/chainmaker.yml
sed -i 's/14321/14325/g' config/wx-org5.chainmaker.org/chainmaker.yml
sed -i 's/24321/24325/g' config/wx-org5.chainmaker.org/chainmaker.yml
# 如果是同步节点,将consensus证书改成common证书:
#sed -i 's/consensus1/common1/g' config/wx-org5.chainmaker.org/chainmaker.yml

echo "修改chainmaker-v2.0.0-wx-org5.chainmaker.org/config/wx-org5.chainmaker.org/chainconfig/bc1.yml中的trust_roots模块"
echo "把所有 ../config/wx-org1.chainmaker.org 修改为 ../config/wx-org5.chainmaker.org"
sed -i "s/wx-org1.chainmaker.org\/certs\/ca/wx-org5.chainmaker.org\/certs\/ca/g" config/wx-org5.chainmaker.org/chainconfig/bc1.yml
}
update_cmc_cert(){
crypto_cert=${cryptogen_path}/bin/crypto-config
cmc_cert=${chainmaker_path}/tools/cmc/testdata/
ls $crypto_cert
ls $cmc_cert

cp -rf $crypto_cert $cmc_cert
}
gen_new_cert
copy_node_file
update_cert
update_config
update_cmc_cert
#sed -i 's/consensus1/common1/g' config/wx-org5.chainmaker.org/chainmaker.yml
