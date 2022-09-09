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
pwd
echo "-------------------------调用合约-------------------------------"
./cmc client contract user invoke \
--contract-name=contract_fact \
--method=invoke_contract \
--sdk-conf-path=./testdata/sdk_config.yml \
--sync-result=true \
--params="{\"method\":\"save\",\"file_name\":\"name007\",\"file_hash\":\"ab3456df5799b87c77e7f88\",\"time\":\"6543234\"}"
echo "-------------------------查询合约-------------------------------"
./cmc client contract user get \
--contract-name=contract_fact \
--method=invoke_contract \
--sdk-conf-path=./testdata/sdk_config.yml \
--params="{\"method\":\"findByFileHash\",\"file_hash\":\"ab3456df5799b87c77e7f88\"}"
echo "-------------------------冻结合约-------------------------------"
./cmc client contract user freeze \
--contract-name=$contract_name \
--sdk-conf-path=./testdata/sdk_config.yml \
--admin-key-file-paths=./testdata/crypto-config/wx-org1.chainmaker.org/user/admin1/admin1.tls.key,./testdata/crypto-config/wx-org2.chainmaker.org/user/admin1/admin1.tls.key,./testdata/crypto-config/wx-org3.chainmaker.org/user/admin1/admin1.tls.key \
--admin-crt-file-paths=./testdata/crypto-config/wx-org1.chainmaker.org/user/admin1/admin1.tls.crt,./testdata/crypto-config/wx-org2.chainmaker.org/user/admin1/admin1.tls.crt,./testdata/crypto-config/wx-org3.chainmaker.org/user/admin1/admin1.tls.crt \
--org-id=wx-org1.chainmaker.org \
--sync-result=true
echo "-------------------------调用合约-------------------------------"
./cmc client contract user invoke \
--contract-name=contract_fact \
--method=invoke_contract \
--sdk-conf-path=./testdata/sdk_config.yml \
--sync-result=true \
--params="{\"method\":\"save\",\"file_name\":\"name007\",\"file_hash\":\"ab3456df5799b87c77e7f88\",\"time\":\"6543234\"}"
echo "-------------------------查询合约-------------------------------"
./cmc client contract user get \
--contract-name=contract_fact \
--method=invoke_contract \
--sdk-conf-path=./testdata/sdk_config.yml \
--params="{\"method\":\"findByFileHash\",\"file_hash\":\"ab3456df5799b87c77e7f88\"}"
echo "-------------------------解冻合约-------------------------------"
./cmc client contract user unfreeze \
--contract-name=$contract_name \
--sdk-conf-path=./testdata/sdk_config.yml \
--admin-key-file-paths=./testdata/crypto-config/wx-org1.chainmaker.org/user/admin1/admin1.tls.key,./testdata/crypto-config/wx-org2.chainmaker.org/user/admin1/admin1.tls.key,./testdata/crypto-config/wx-org3.chainmaker.org/user/admin1/admin1.tls.key \
--admin-crt-file-paths=./testdata/crypto-config/wx-org1.chainmaker.org/user/admin1/admin1.tls.crt,./testdata/crypto-config/wx-org2.chainmaker.org/user/admin1/admin1.tls.crt,./testdata/crypto-config/wx-org3.chainmaker.org/user/admin1/admin1.tls.crt \
--org-id=wx-org1.chainmaker.org \
--sync-result=true
echo "-------------------------调用合约-------------------------------"
./cmc client contract user invoke \
--contract-name=contract_fact \
--method=invoke_contract \
--sdk-conf-path=./testdata/sdk_config.yml \
--sync-result=true \
--params="{\"method\":\"save\",\"file_name\":\"name007\",\"file_hash\":\"ab3456df5799b87c77e7f88\",\"time\":\"6543234\"}"
echo "-------------------------查询合约-------------------------------"
./cmc client contract user get \
--contract-name=contract_fact \
--method=invoke_contract \
--sdk-conf-path=./testdata/sdk_config.yml \
--params="{\"method\":\"findByFileHash\",\"file_hash\":\"ab3456df5799b87c77e7f88\"}"
