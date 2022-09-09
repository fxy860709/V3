cmc_path='../../chainmaker-go/tools/cmc'
cd ${cmc_path}
CURRENT_PWD=$(pwd)
echo ${CURRENT_PWD}
contract_name=$1
contract_name_default="rust_transfer"
if [ -z "$contract_name" ];then
        contract_name=$contract_name_default
else
        contract_name=$1
fi
echo $contract_name
echo "-------------------------部署/创建合约-------------------------------"
./cmc client contract user create \
--contract-name=$contract_name \
--runtime-type=WASMER \
--byte-code-path=./testdata/asset-wasm-demo/rust-asset-2.1.0.wasm \
--version=1.0 \
--sdk-conf-path=./testdata/sdk_config_pk.yml \
--admin-key-file-paths=./testdata/crypto-config/node1/admin/admin1/admin1.key \
--sync-result=true \
--params="{\"issue_limit\":\"100000000\",\"total_supply\":\"1000000000\"}" \


