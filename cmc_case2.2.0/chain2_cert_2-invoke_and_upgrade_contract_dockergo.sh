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
version=$2
version_default="2.0"
if [ -z "$version_name" ];then
        version_name=$version_default
else
        version_name=$2
fi
echo $contract_name
echo $version

invoke_chain1(){
echo "------------------------chain1-调用合约-------------------------------"
./cmc client contract user invoke \
--contract-name=$contract_name \
--method=invoke_contract \
--sdk-conf-path=./testdata/sdk_config.yml \
--sync-result=true \
--params="{\"method\":\"save\",\"file_name\":\"chain1_008\",\"file_hash\":\"ab3456df5799b87c77e7888\",\"time\":\"6543888\"}" \
--chain-id="chain1"
}
invoke_chain2(){
echo "------------------------chain2-调用合约-------------------------------"
./cmc client contract user invoke \
--contract-name=$contract_name \
--method=invoke_contract \
--sdk-conf-path=./testdata/sdk_config.yml \
--sync-result=true \
--params="{\"method\":\"save\",\"file_name\":\"chain2_008\",\"file_hash\":\"ab3456df5799b87c77e7008\",\"time\":\"6543008\"}" \
--chain-id="chain2"
}
get_chain1(){
echo "------------------------chain1-查询合约-------------------------------"
./cmc client contract user get \
--contract-name=$contract_name \
--method=invoke_contract \
--sdk-conf-path=./testdata/sdk_config.yml \
--params="{\"method\":\"findByFileHash\",\"file_hash\":\"ab3456df5799b87c77e7888\"}" \
--chain-id="chain1"
}
get_chain2(){
echo "------------------------chain2-查询合约-------------------------------"
./cmc client contract user get \
--contract-name=$contract_name \
--method=invoke_contract \
--sdk-conf-path=./testdata/sdk_config.yml \
--params="{\"method\":\"findByFileHash\",\"file_hash\":\"ab3456df5799b87c77e7008\"}" \
--chain-id="chain2"
}
upgrade_chain1(){
echo "------------------------chain1-升级合约-------------------------------"
./cmc client contract user upgrade \
--contract-name=$contract_name \
--runtime-type=DOCKER_GO \
--byte-code-path=./testdata/docker-go-demo/contract_fact.7z \
--version=$version \
--sdk-conf-path=./testdata/sdk_config.yml \
--admin-key-file-paths=./testdata/crypto-config/wx-org1.chainmaker.org/user/admin1/admin1.tls.key,./testdata/crypto-config/wx-org2.chainmaker.org/user/admin1/admin1.tls.key,./testdata/crypto-config/wx-org3.chainmaker.org/user/admin1/admin1.tls.key,./testdata/crypto-config/wx-org4.chainmaker.org/user/admin1/admin1.tls.key \
--admin-crt-file-paths=./testdata/crypto-config/wx-org1.chainmaker.org/user/admin1/admin1.tls.crt,./testdata/crypto-config/wx-org2.chainmaker.org/user/admin1/admin1.tls.crt,./testdata/crypto-config/wx-org3.chainmaker.org/user/admin1/admin1.tls.crt,./testdata/crypto-config/wx-org4.chainmaker.org/user/admin1/admin1.tls.crt \
--sync-result=true \
--params="{}" \
--chain-id="chain1"
}
upgrade_chain2(){
echo "------------------------chain2-升级合约-------------------------------"
./cmc client contract user upgrade \
--contract-name=$contract_name \
--runtime-type=DOCKER_GO \
--byte-code-path=./testdata/docker-go-demo/contract_fact.7z \
--version=$version \
--sdk-conf-path=./testdata/sdk_config.yml \
--admin-key-file-paths=./testdata/crypto-config/wx-org1.chainmaker.org/user/admin1/admin1.tls.key,./testdata/crypto-config/wx-org2.chainmaker.org/user/admin1/admin1.tls.key,./testdata/crypto-config/wx-org3.chainmaker.org/user/admin1/admin1.tls.key,./testdata/crypto-config/wx-org4.chainmaker.org/user/admin1/admin1.tls.key \
--admin-crt-file-paths=./testdata/crypto-config/wx-org1.chainmaker.org/user/admin1/admin1.tls.crt,./testdata/crypto-config/wx-org2.chainmaker.org/user/admin1/admin1.tls.crt,./testdata/crypto-config/wx-org3.chainmaker.org/user/admin1/admin1.tls.crt,./testdata/crypto-config/wx-org4.chainmaker.org/user/admin1/admin1.tls.crt \
--sync-result=true \
--params="{}" \
--chain-id="chain2"
}
invoke_chain1
invoke_chain2
get_chain1
get_chain2
upgrade_chain1
upgrade_chain2
#invoke_chain1
#invoke_chain2
get_chain1
get_chain2

