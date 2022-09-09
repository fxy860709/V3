cmc_path='../../chainmaker-go/tools/cmc'
cd ${cmc_path}
contract_name=$1
contract_name_default="fact"
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
--byte-code-path=./testdata/claim-wasm-demo/rust-fact-2.0.0.wasm \
--version=1.0 \
--sdk-conf-path=./testdata/sdk_config_pwk.yml \
--admin-org-ids=wx-org1.chainmaker.org,wx-org2.chainmaker.org,wx-org3.chainmaker.org \
--admin-key-file-paths=./testdata/crypto-config/wx-org1.chainmaker.org/admin/admin.key,./testdata/crypto-config/wx-org2.chainmaker.org/admin/admin.key,./testdata/crypto-config/wx-org3.chainmaker.org/admin/admin.key \
--sync-result=true \
--params="{}"
