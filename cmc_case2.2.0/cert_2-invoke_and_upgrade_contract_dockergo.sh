cmc_path='../../chainmaker-go/tools/cmc'
cd ${cmc_path}
contract_name=$1
version=$2
contract_name_default="contract_fact"
if [ -z "$contract_name" ];then
        contract_name=$contract_name_default
else
        contract_name=$1
fi
if [ -z "$version" ];then
	read -p "输入升级版本号: " version
fi

echo $contract_name
invoke(){
echo "-------------------------调用合约-------------------------------"
./cmc client contract user invoke \
--contract-name=$contract_name \
--method=invoke_contract \
--sdk-conf-path=./testdata/sdk_config.yml \
--sync-result=true \
--params="{\"method\":\"save\",\"file_name\":\"name007\",\"file_hash\":\"ab3456df5799b87c77e7f88\",\"time\":\"6543234\"}"
}
get(){
echo "-------------------------查询合约-------------------------------"
./cmc client contract user get \
--contract-name=$contract_name \
--method=invoke_contract \
--sdk-conf-path=./testdata/sdk_config.yml \
--params="{\"method\":\"findByFileHash\",\"file_hash\":\"ab3456df5799b87c77e7f88\"}"
}
upgrade(){
echo "-------------------------升级合约-------------------------------"
./cmc client contract user upgrade \
--contract-name=$contract_name \
--runtime-type=DOCKER_GO \
--byte-code-path=./testdata/docker-go-demo/contract_fact.7z \
--version=$version \
--sdk-conf-path=./testdata/sdk_config.yml \
--admin-key-file-paths=./testdata/crypto-config/wx-org1.chainmaker.org/user/admin1/admin1.tls.key,./testdata/crypto-config/wx-org2.chainmaker.org/user/admin1/admin1.tls.key,./testdata/crypto-config/wx-org3.chainmaker.org/user/admin1/admin1.tls.key,./testdata/crypto-config/wx-org4.chainmaker.org/user/admin1/admin1.tls.key \
--admin-crt-file-paths=./testdata/crypto-config/wx-org1.chainmaker.org/user/admin1/admin1.tls.crt,./testdata/crypto-config/wx-org2.chainmaker.org/user/admin1/admin1.tls.crt,./testdata/crypto-config/wx-org3.chainmaker.org/user/admin1/admin1.tls.crt,./testdata/crypto-config/wx-org4.chainmaker.org/user/admin1/admin1.tls.crt \
--sync-result=true \
--params="{}"
}
invoke
get
upgrade
invoke
get
