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
echo "-------------------------部署/创建合约-------------------------------"
./cmc client contract user create \
--contract-name=${contract_name} \
--runtime-type=DOCKER_GO \
--byte-code-path=./testdata/docker-go-demo/${contract_name}.7z \
--version=1.0 \
--sdk-conf-path=./testdata/sdk_config_pk.yml \
--admin-key-file-paths=./testdata/crypto-config/node1/admin/admin1/admin1.key \
--sync-result=true \
--params="{}"


