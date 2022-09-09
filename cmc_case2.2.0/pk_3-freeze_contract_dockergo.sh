cmc_path='../../chainmaker-go/tools/cmc'
cd ${cmc_path}
contract_name=$1
contract_name_default="contract_fact"
if [ -z "$contract_name" ];then
        contract_name=$contract_name_default
else
        contract_name=$1
fi
echo $contract_name
pwd
invoke(){
echo "-------------------------调用合约-------------------------------"
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
--method=invoke_contract \
--sdk-conf-path=./testdata/sdk_config_pk.yml \
--params="{\"method\":\"findByFileHash\",\"file_hash\":\"ab3456df5799b87c77e7f88\"}"
}
freeze(){
echo "-------------------------冻结合约-------------------------------"
./cmc client contract user freeze \
--contract-name=$contract_name \
--sdk-conf-path=./testdata/sdk_config_pk.yml \
--admin-key-file-paths=./testdata/crypto-config/node1/admin/admin1/admin1.key \
--sync-result=true
}
unfreeze(){
echo "-------------------------解冻合约-------------------------------"
./cmc client contract user unfreeze \
--contract-name=$contract_name \
--sdk-conf-path=./testdata/sdk_config_pk.yml \
--admin-key-file-paths=./testdata/crypto-config/node1/admin/admin1/admin1.key \
--sync-result=true
}

invoke
get
freeze
invoke
get
unfreeze
invoke
get
