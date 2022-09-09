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
echo "-------------------------升级/变更合约-------------------------------"
./cmc client contract user upgrade \
--contract-name=$contract_name \
--runtime-type=WASMER \
--byte-code-path=../../test/wasm/rust-fact-1.2.0.wasm \
--version=2.0 \
--sdk-conf-path=./testdata/sdk_config.yml \
--admin-org-ids=wx-org1.chainmaker.org \
--admin-key-file-paths=./testdata/crypto-config/wx-org1.chainmaker.org/user/admin1/admin1.tls.key \
--admin-crt-file-paths=./testdata/crypto-config/wx-org1.chainmaker.org/user/admin1/admin1.tls.crt \
--org-id=wx-org1.chainmaker.org \
--sync-result=false \
--params="{}"





