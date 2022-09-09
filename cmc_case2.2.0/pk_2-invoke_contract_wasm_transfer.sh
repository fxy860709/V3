cmc_path='../../chainmaker-go/tools/cmc'
cd ${cmc_path}
CURRENT_PWD=$(pwd)
echo ${CURRENT_PWD}
contract_name=$1
contract_name_default="transfer"
if [ -z "$contract_name" ];then
        contract_name=$contract_name_default
else
        contract_name=$1
fi
echo $contract_name
echo "-------------------------获取org1地址-------------------------------"
./cmc client contract user invoke \
--contract-name="rust_transfer" \
--method=query_address \
--sdk-conf-path=./testdata/sdk_config_pk.yml \
--params="" \
--sync-result=true


