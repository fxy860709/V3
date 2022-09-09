cmc_path='../../chainmaker-go/tools/cmc'
cd ${cmc_path}
contract_name=$1
version=$2
contract_name_default="contract_fact"
version_default="2.0"
if [ -z "$contract_name" ];then
        contract_name=$contract_name_default
else
        contract_name=$1
fi
if [ -z "$version" ];then
        version=$version_default
else
        version=$2
fi
echo $contract_name
invoke(){
echo "-------------------------执行/调用合约-------------------------------"
./cmc client contract user invoke \
--contract-name=$contract_name \
--method=invoke_contract \
--sdk-conf-path=./testdata/sdk_config_pk.yml \
--sync-result=true \
--params="{\"method\":\"save\",\"file_name\":\"name007\",\"file_hash\":\"ab3456df5799b87c77e7f88\",\"time\":\"6543234\"}"

}
get(){
echo "-------------------------查询合约-------------------------------"
./cmc client contract user get \
--contract-name=$contract_name \
--method=find_by_file_hash \
--sdk-conf-path=./testdata/sdk_config_pk.yml \
--params="{\"file_hash\":\"ab3456df5799b87c77e7f88\"}"
}
upgrade(){
echo "-------------------------升级合约-------------------------------"
./cmc client contract user upgrade \
--contract-name=$contract_name \
--runtime-type=DOCKER_GO \
--byte-code-path=./testdata/docker-go-demo/contract_fact.7z \
--version=2.0 \
--sdk-conf-path=./testdata/sdk_config_pk.yml \
--admin-key-file-paths=./testdata/crypto-config/node1/admin/admin1/admin1.key \
--sync-result=true \
--params="{}"
#--params="{\"issue_limit\":\"1000\",\"total_supply\":\"10000\",\"manager_pk\":\"\"}"
}
invoke
get
upgrade
invoke
get

