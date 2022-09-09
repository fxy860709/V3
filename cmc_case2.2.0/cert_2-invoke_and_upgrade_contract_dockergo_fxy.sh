cmc_path='../../chainmaker-go/tools/cmc'
cd ${cmc_path}

current=`date "+%Y-%m-%d %H:%M:%S"`
timeStamp=`date -d "$current" +%s` 
currentTimeStamp=$((timeStamp*1000+10#`date "+%N"`/1000000)) 
echo $currentTimeStamp

contract_name=$1
contract_name_default="fxy_dockervm"
if [ -z "$contract_name" ];then
        contract_name=$contract_name_default
else
        contract_name=$1
fi
echo $contract_name

version=$2
version_default="2.0"
if [ -z "$version" ];then
        version=$version_default
else
        version=$2
fi
echo $version

param_file_name="fxy001-chain1"
param_file_hash="ab3456df5799b87c77e7f88"
param_time=$currentTimeStamp
param_key="fxy_keychain1"
param_field="fxy_fieldchain1"
param_value="fxy_valuechain1"


invoke_save(){
echo "-------------------------调用合约save-------------------------------"
./cmc client contract user invoke \
--contract-name=$contract_name \
--method=invoke_contract \
--sdk-conf-path=./testdata/sdk_config.yml \
--sync-result=true \
--params="{\"method\":\"save\",\"file_name\":\"save $param_file_name\",\"file_hash\":\"$param_file_hash\",\"time\":\"$param_time\"}"

}
invoke_display(){
echo "-------------------------调用合约display-------------------------------"
./cmc client contract user invoke \
--contract-name=$contract_name \
--method=invoke_contract \
--sdk-conf-path=./testdata/sdk_config.yml \
--sync-result=true \
--params="{\"method\":\"display\"}"
}
invoke_put_state(){
echo "-------------------------调用合约put_state-------------------------------"
./cmc client contract user invoke \
--contract-name=$contract_name \
--method=invoke_contract \
--sdk-conf-path=./testdata/sdk_config.yml \
--sync-result=true \
--params="{\"method\":\"put_state\",\"key\":\"$param_key\",\"field\":\"$param_field\",\"value\":\"put_state $param_value\"}"
echo "-------------------------调用合约get_state-------------------------------"
./cmc client contract user invoke \
--contract-name=$contract_name \
--method=invoke_contract \
--sdk-conf-path=./testdata/sdk_config.yml \
--sync-result=true \
--params="{\"method\":\"get_state\",\"key\":\"$param_key\",\"field\":\"$param_field\"}"
echo "-------------------------调用合约-put_state_byte------------------------------"
./cmc client contract user invoke \
--contract-name=$contract_name \
--method=invoke_contract \
--sdk-conf-path=./testdata/sdk_config.yml \
--sync-result=true \
--params="{\"method\":\"put_state_byte\",\"key\":\"$param_key\",\"field\":\"$param_field\",\"value\":\"put_state_byte $param_value\"}"
echo "-------------------------调用合约-get_state_byte------------------------------"
./cmc client contract user invoke \
--contract-name=$contract_name \
--method=invoke_contract \
--sdk-conf-path=./testdata/sdk_config.yml \
--sync-result=true \
--params="{\"method\":\"get_state_byte\",\"key\":\"$param_key\",\"field\":\"$param_field\"}"



echo "-------------------------调用合约-put_state_from_key-----------------------------"
./cmc client contract user invoke \
--contract-name=$contract_name \
--method=invoke_contract \
--sdk-conf-path=./testdata/sdk_config.yml \
--sync-result=true \
--params="{\"method\":\"put_state_from_key\",\"key\":\"$param_key\",\"value\":\"put_state_from_key $param_value\"}"
echo "-------------------------调用合约-get_state_from_key------------------------------"
./cmc client contract user invoke \
--contract-name=$contract_name \
--method=invoke_contract \
--sdk-conf-path=./testdata/sdk_config.yml \
--sync-result=true \
--params="{\"method\":\"get_state_from_key\",\"key\":\"$param_key\"}"
echo "-------------------------调用合约-put_state_from_key_byte-----------------------------"
./cmc client contract user invoke \
--contract-name=$contract_name \
--method=invoke_contract \
--sdk-conf-path=./testdata/sdk_config.yml \
--sync-result=true \
--params="{\"method\":\"put_state_from_key_byte\",\"key\":\"$param_key\",\"value\":\"put_state_from_key_byte $param_value\"}"
echo "-------------------------调用合约-get_state_from_key_byte------------------------------"
./cmc client contract user invoke \
--contract-name=$contract_name \
--method=invoke_contract \
--sdk-conf-path=./testdata/sdk_config.yml \
--sync-result=true \
--params="{\"method\":\"get_state_from_key_byte\",\"key\":\"$param_key\"}"
}

get(){
echo "-------------------------查询合约-------------------------------"
./cmc client contract user get \
--contract-name=$contract_name \
--method=invoke_contract \
--sdk-conf-path=./testdata/sdk_config.yml \
--params="{\"method\":\"findByFileHash\",\"file_hash\":\"$param_file_hash\"}"
}
upgrade_fact(){
echo "-------------------------升级合约-------------------------------"
./cmc client contract user upgrade \
--contract-name=contract_fact \
--runtime-type=DOCKER_GO \
--byte-code-path=./testdata/docker-go-demo/contract_fact.7z \
--version=$version \
--sdk-conf-path=./testdata/sdk_config.yml \
--admin-key-file-paths=./testdata/crypto-config/wx-org1.chainmaker.org/user/admin1/admin1.tls.key,./testdata/crypto-config/wx-org2.chainmaker.org/user/admin1/admin1.tls.key,./testdata/crypto-config/wx-org3.chainmaker.org/user/admin1/admin1.tls.key,./testdata/crypto-config/wx-org4.chainmaker.org/user/admin1/admin1.tls.key \
--admin-crt-file-paths=./testdata/crypto-config/wx-org1.chainmaker.org/user/admin1/admin1.tls.crt,./testdata/crypto-config/wx-org2.chainmaker.org/user/admin1/admin1.tls.crt,./testdata/crypto-config/wx-org3.chainmaker.org/user/admin1/admin1.tls.crt,./testdata/crypto-config/wx-org4.chainmaker.org/user/admin1/admin1.tls.crt \
--sync-result=true \
--params="{}"
}
upgrade_fxy(){
echo "-------------------------升级合约-------------------------------"
./cmc client contract user upgrade \
--contract-name=$contract_name \
--runtime-type=DOCKER_GO \
--byte-code-path=./testdata/docker-go-demo/$contract_name.7z \
--version=$version \
--sdk-conf-path=./testdata/sdk_config.yml \
--admin-key-file-paths=./testdata/crypto-config/wx-org1.chainmaker.org/user/admin1/admin1.tls.key,./testdata/crypto-config/wx-org2.chainmaker.org/user/admin1/admin1.tls.key,./testdata/crypto-config/wx-org3.chainmaker.org/user/admin1/admin1.tls.key,./testdata/crypto-config/wx-org4.chainmaker.org/user/admin1/admin1.tls.key \
--admin-crt-file-paths=./testdata/crypto-config/wx-org1.chainmaker.org/user/admin1/admin1.tls.crt,./testdata/crypto-config/wx-org2.chainmaker.org/user/admin1/admin1.tls.crt,./testdata/crypto-config/wx-org3.chainmaker.org/user/admin1/admin1.tls.crt,./testdata/crypto-config/wx-org4.chainmaker.org/user/admin1/admin1.tls.crt \
--sync-result=true \
--params="{}"
}
invoke_other(){
echo "-------------------------调用合约-time_out-----------------------------"
./cmc client contract user invoke \
--contract-name=$contract_name \
--method=invoke_contract \
--sdk-conf-path=./testdata/sdk_config.yml \
--sync-result=true \
--params="{\"method\":\"time_out\"}"
echo " "
echo "-------------------------调用合约-out_of_range-----------------------------"
./cmc client contract user invoke \
--contract-name=$contract_name \
--method=invoke_contract \
--sdk-conf-path=./testdata/sdk_config.yml \
--sync-result=true \
--params="{\"method\":\"out_of_range\"}"
echo " "
}
invoke_cross(){
echo "-------------------------跨合约调用 调用合约-cross_contract-----------------------------"
./cmc client contract user invoke \
--contract-name=$contract_name \
--method=invoke_contract \
--sdk-conf-path=./testdata/sdk_config.yml \
--sync-result=true \
--params="{\"method\":\"cross_contract\",\"contract_name\":\"contract_fact\",\"contract_version\":\"$version\",\"contract_method\":\"save\",\"findByFileHash\":\"ab3456df5799b87c77e7f88\"}"
}
invoke_del(){
echo "------------------------del state-------------------------------"
echo "-------------------------调用合约-put_state-------------------------------"
./cmc client contract user invoke \
--contract-name=$contract_name \
--method=invoke_contract \
--sdk-conf-path=./testdata/sdk_config.yml \
--sync-result=true \
--params="{\"method\":\"put_state\",\"key\":\"delete_key\",\"field\":\"del_field\",\"value\":\"del_value\"}"
echo "-------------------------调用合约-get_state------------------------------"
./cmc client contract user invoke \
--contract-name=$contract_name \
--method=invoke_contract \
--sdk-conf-path=./testdata/sdk_config.yml \
--sync-result=true \
--params="{\"method\":\"get_state\",\"key\":\"delete_key\",\"field\":\"del_field\"}"
echo "-------------------------调用合约-del_state-----------------------------"
./cmc client contract user invoke \
--contract-name=$contract_name \
--method=invoke_contract \
--sdk-conf-path=./testdata/sdk_config.yml \
--sync-result=true \
--params="{\"method\":\"del_state\",\"key\":\"delete_key\",\"field\":\"del_field\"}"
echo "-------------------------调用合约-get_state------------------------------"
./cmc client contract user invoke \
--contract-name=$contract_name \
--method=invoke_contract \
--sdk-conf-path=./testdata/sdk_config.yml \
--sync-result=true \
--params="{\"method\":\"get_state\",\"key\":\"delete_key\",\"field\":\"del_field\"}"
}

#invoke
get #查询合约
upgrade_fxy
invoke_save # 存证
invoke_display # 合约是否可用
invoke_put_state #各种put state
invoke_other #超时 越界
#upgrade
get
invoke_cross #跨合约调用
invoke_del #删除
