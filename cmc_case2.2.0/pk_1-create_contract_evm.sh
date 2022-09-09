cmc_path='../../chainmaker-go/tools/cmc'
cd ${cmc_path}
CURRENT_PWD=$(pwd)
echo ${CURRENT_PWD}
contract_name=$1
contract_name_default="balance001"
if [ -z "$contract_name" ];then
        contract_name=$contract_name_default
else
        contract_name=$1
fi
echo $contract_name
echo "-------------------------部署/创建合约-------------------------------"
./cmc client contract user create \
--contract-name=$contract_name \
--runtime-type=EVM \
--byte-code-path=./testdata/balance-evm-demo/ledger_balance.bin \
--abi-file-path=./testdata/balance-evm-demo/ledger_balance.abi \
--version=1.0 \
--sdk-conf-path=./testdata/sdk_config_pk.yml \
--admin-key-file-paths=./testdata/crypto-config/node1/admin/admin1/admin1.key \
--sync-result=true

