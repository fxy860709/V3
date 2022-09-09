cmc_path='../../chainmaker-go/tools/cmc'
cd ${cmc_path}
contract_name=$1
contract_name_default="532c238cec7071ce8655aba07e50f9fb16f72ca1"
if [ -z "$contract_name" ];then
        contract_name=$contract_name_default
else
        contract_name=$1
fi
version=$2
version_default="2.0"
if [ -z "$version" ];then
        version=$version_default
else
        version=$2
fi
echo $contract_name
pwd
upgrade(){
echo "-------------------------升级合约-------------------------------"
./cmc client contract user upgrade \
--contract-name=$contract_name \
--runtime-type=EVM \
--byte-code-path=./testdata/balance-evm-demo/ledger_balance.bin \
--version=$version \
--sdk-conf-path=./testdata/sdk_config_pk.yml \
--admin-key-file-paths=./testdata/crypto-config/node1/admin/admin1/admin1.key \
--sync-result=true \
--params="{}"

}
invoke_evm(){
echo "-------------------------调用合约-------------------------------"
./cmc client contract user invoke \
--contract-name=$contract_name \
--method=updateBalance \
--sdk-conf-path=./testdata/sdk_config_pk.yml \
--params="[{\"uint256\": \"10000\"},{\"address\": \"0xa166c92f4c8118905ad984919dc683a7bdb295c1\"}]" \
--sync-result=true \
--abi-file-path=./testdata/balance-evm-demo/ledger_balance.abi
}
get_evm(){
echo "-------------------------查询合约-------------------------------"
./cmc client contract user get \
--contract-name=$contract_name \
--method=find_by_file_hash \
--sdk-conf-path=./testdata/sdk_config_pk.yml \
--params="{\"file_hash\":\"ab3456df5799b87c77e7f88\"}"
}
invoke_evm
get_evm
upgrade_evm
invoke_evm
get_evm
