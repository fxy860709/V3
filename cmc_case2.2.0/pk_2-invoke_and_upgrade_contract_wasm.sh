cmc_path='../../chainmaker-go/tools/cmc'
cd ${cmc_path}
contract_name=$1
version=$2
contract_name_default="fact"
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
invoke_wasm(){
echo "-------------------------执行/调用合约-------------------------------"
./cmc client contract user invoke \
--contract-name=$contract_name \
--method=save \
--sdk-conf-path=./testdata/sdk_config_pk.yml \
--params="{\"file_name\":\"name007\",\"file_hash\":\"ab3456df5799b87c77e7f88\",\"time\":\"6543234\"}" \
--sync-result=true
}
get_wasm(){
echo "-------------------------查询合约-------------------------------"
./cmc client contract user get \
--contract-name=$contract_name \
--method=find_by_file_hash \
--sdk-conf-path=./testdata/sdk_config_pk.yml \
--params="{\"file_hash\":\"ab3456df5799b87c77e7f88\"}"
}
upgrade_wasm(){
echo "-------------------------升级合约-------------------------------"
./cmc client contract user upgrade \
--contract-name=$contract_name \
--runtime-type=WASMER \
--byte-code-path=./testdata/claim-wasm-demo/rust-fact-2.0.0.wasm \
--version=$version \
--sdk-conf-path=./testdata/sdk_config_pk.yml \
--admin-key-file-paths=./testdata/crypto-config/node1/admin/admin1/admin1.key \
--sync-result=true \
--params="{}"
}
invoke_wasm
get_wasm
upgrade_wasm
invoke_wasm
get_wasm




