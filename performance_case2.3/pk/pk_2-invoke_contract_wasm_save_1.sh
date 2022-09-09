cmc_path='../../../chainmaker-go/tools/cmc_pk'
cd ${cmc_path}
contract_name=$1
contract_name_default="fact"
if [ -z "$contract_name" ];then
        contract_name=$contract_name_default
else
        contract_name=$1
fi
echo $contract_name
./cmc parallel invoke \
--loopNum=1  \
--printTime=5 \
--threadNum=1 \
--timeout=200 \
--sleepTime=1000 \
--climbTime=5  \
--use-tls=false \
--showKey=true \
--contract-name="$contract_name" \
--method="save" \
--pairs="" \
--hosts="172.21.48.7:12301" \
--pairs-file="./testdata/save.json" \
--auth-type=3 \
--user-keys=./testdata/crypto-config/node1/user/client1/client1.key \
--admin-sign-keys=./testdata/crypto-config/node1/admin/admin1/admin1.key
