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
echo "-------------------------调用合约-------------------------------"
./cmc client contract user invoke \
--contract-name=contract_fact \
--method=invoke_contract \
--sdk-conf-path=./testdata/sdk_config.yml \
--sync-result=true \
--params="{\"method\":\"save\",\"file_name\":\"name007\",\"file_hash\":\"ab3456df5799b87c77e7f88\",\"time\":\"6543234\"}"

