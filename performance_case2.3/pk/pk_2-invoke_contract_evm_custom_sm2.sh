cmc_path='../../../chainmaker-go/tools/cmc_pk'
cd ${cmc_path}
contract_name=$2
contract_name_default="532c238cec7071ce8655aba07e50f9fb16f72ca1"
if [ -z "$contract_name" ];then
        contract_name=$contract_name_default
else
        contract_name=$1
fi
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
--method="2e2ad001" \
--hash-algorithm=SM3 \
--pairs="" \
--hosts="172.21.48.7:12301" \
--pairs-file="./testdata/evm_params.json" \
--auth-type=3 \
--user-keys=./testdata/crypto-config/node1/user/client1/client1.key \
--admin-sign-keys=./testdata/crypto-config/node1/admin/admin1/admin1.key
