cmc_path='../../chainmaker-go/tools/cmc'
cd ${cmc_path}
contract_name=$1
contract_name_default="532c238cec7071ce8655aba07e50f9fb16f72ca1"
if [ -z "$contract_name" ];then
        contract_name=$contract_name_default
else
        contract_name=$1
fi
echo $contract_name
pwd
echo "-------------------------调用合约-------------------------------"
./cmc client contract user invoke \
--contract-name=$contract_name \
--method=updateBalance \
--sdk-conf-path=./testdata/sdk_config.yml \
--params="[{\"uint256\": \"10000\"},{\"address\": \"0xa166c92f4c8118905ad984919dc683a7bdb295c1\"}]" \
--sync-result=true \
--abi-file-path=./testdata/balance-evm-demo/ledger_balance.abi
echo "-------------------------查询合约-------------------------------"
./cmc client contract user get \
--contract-name=$contract_name \
--method=find_by_file_hash \
--sdk-conf-path=./testdata/sdk_config.yml \
--params="{\"file_hash\":\"ab3456df5799b87c77e7f88\"}"
echo "-------------------------升级合约-------------------------------"
./cmc client contract user upgrade \
--contract-name=$contract_name \
--runtime-type=EVM \
--byte-code-path=./testdata/balance-evm-demo/ledger_balance.bin \
--version=2.0 \
--sdk-conf-path=./testdata/sdk_config.yml \
--admin-key-file-paths=./testdata/crypto-config/wx-org1.chainmaker.org/user/admin1/admin1.tls.key,./testdata/crypto-config/wx-org2.chainmaker.org/user/admin1/admin1.tls.key,./testdata/crypto-config/wx-org3.chainmaker.org/user/admin1/admin1.tls.key \
--admin-crt-file-paths=./testdata/crypto-config/wx-org1.chainmaker.org/user/admin1/admin1.tls.crt,./testdata/crypto-config/wx-org2.chainmaker.org/user/admin1/admin1.tls.crt,./testdata/crypto-config/wx-org3.chainmaker.org/user/admin1/admin1.tls.crt \
--org-id=wx-org1.chainmaker.org \
--sync-result=true \
--params="{}"
echo "-------------------------调用合约-------------------------------"
./cmc client contract user invoke \
--contract-name=$contract_name \
--method=updateBalance \
--sdk-conf-path=./testdata/sdk_config.yml \
--params="[{\"uint256\": \"10000\"},{\"address\": \"0xa166c92f4c8118905ad984919dc683a7bdb295c1\"}]" \
--sync-result=true \
--abi-file-path=./testdata/balance-evm-demo/ledger_balance.abi
echo "-------------------------查询合约-------------------------------"
./cmc client contract user get \
--contract-name=$contract_name \
--method=find_by_file_hash \
--sdk-conf-path=./testdata/sdk_config.yml \
--params="{\"file_hash\":\"ab3456df5799b87c77e7f88\"}"
