cmc_path='../../../chainmaker-go/tools/cmc_pk'
cd ${cmc_path}
contract_name=$1
contract_name_default="fact230"
if [ -z "$contract_name" ];then
        contract_name=$contract_name_default
else
        contract_name=$1
fi
echo $contract_name

echo "-------------------------执行/调用合约-------------------------------"
./cmc client contract user invoke \
--contract-name=$contract_name \
--method=invoke_contract \
--sdk-conf-path=./testdata/sdk_config_pk.yml \
--sync-result=true \
--params="{\"method\":\"Save\",\"file_name\":\"name007\",\"file_hash\":\"ab3456df5799b87c77e7f88\",\"time\":\"6543234\"}"

