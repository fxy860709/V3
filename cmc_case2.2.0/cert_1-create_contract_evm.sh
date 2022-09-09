cmc_path='../../chainmaker-go/tools/cmc'
cd ${cmc_path}
contract_name=$1
contract_name_default="balance001"
if [ -z "$contract_name" ];then
        contract_name=$contract_name_default
else
        contract_name=$1
fi
echo $contract_name
pwd
echo "-------------------------部署/创建合约-------------------------------"
./cmc client contract user create \
--contract-name=$contract_name \
--runtime-type=EVM \
--byte-code-path=./testdata/balance-evm-demo/ledger_balance.bin \
--version=1.0 \
--sdk-conf-path=./testdata/sdk_config.yml \
--admin-key-file-paths=./testdata/crypto-config/wx-org1.chainmaker.org/user/admin1/admin1.tls.key,./testdata/crypto-config/wx-org2.chainmaker.org/user/admin1/admin1.tls.key,./testdata/crypto-config/wx-org3.chainmaker.org/user/admin1/admin1.tls.key \
--admin-crt-file-paths=./testdata/crypto-config/wx-org1.chainmaker.org/user/admin1/admin1.tls.crt,./testdata/crypto-config/wx-org2.chainmaker.org/user/admin1/admin1.tls.crt,./testdata/crypto-config/wx-org3.chainmaker.org/user/admin1/admin1.tls.crt \
--sync-result=true
