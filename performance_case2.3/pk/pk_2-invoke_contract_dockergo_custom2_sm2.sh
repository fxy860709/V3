cmc_path='../../../chainmaker-go/tools/cmc_pk'
cd ${cmc_path}
contract_name=$2
contract_name_default="fact230"
if [ -z "$contract_name" ];then
        contract_name=$contract_name_default
else
        contract_name=$2
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
--hash-algorithm=SM3 \
--method="Save" \
--pairs="" \
--hosts="172.21.48.3:12302" \
--pairs-file="./testdata/save.json" \
--auth-type=3 \
--user-keys=./testdata/crypto-config/node1/user/client1/client1.key 
#--output-result=true
