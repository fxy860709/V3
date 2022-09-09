cmc_path='../../../chainmaker-go/tools/cmc_pk'
cd ${cmc_path}
contract_name="fact"
echo $contract_name
./cmc parallel invoke \
--loopNum=600  \
--printTime=5 \
--threadNum=$1 \
--timeout=1000 \
--sleepTime=1000 \
--climbTime=5  \
--use-tls=false \
--showKey=false \
--contract-name="$contract_name" \
--method="save" \
--pairs="" \
--hosts="172.21.48.7:12301" \
--pairs-file="./testdata/save.json" \
--auth-type=3 \
--user-keys=./testdata/crypto-config/node1/user/client1/client1.key \
--admin-sign-keys=./testdata/crypto-config/node1/admin/admin1/admin1.key
