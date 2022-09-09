cmc_path='../../../chainmaker-go/tools/cmc_cert'
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
--use-tls=true \
--showKey=true \
--contract-name="$contract_name" \
--method="save" \
--pairs="" \
--hosts="172.21.48.7:12301" \
--pairs-file="./testdata/save.json" \
--org-IDs="wx-org1.chainmaker.org" \
--user-keys="./testdata/crypto-config/wx-org1.chainmaker.org/user/client1/client1.sign.key" \
--user-crts="./testdata/crypto-config/wx-org1.chainmaker.org/user/client1/client1.sign.crt" \
--org-ids="wx-org1.chainmaker.org" \
--ca-path="./testdata/crypto-config/wx-org1.chainmaker.org/ca" \
--admin-sign-keys="./testdata/crypto-config/wx-org1.chainmaker.org/user/admin1/admin1.sign.key,./testdata/crypto-config/wx-org2.chainmaker.org/user/admin1/admin1.sign.key,./testdata/crypto-config/wx-org3.chainmaker.org/user/admin1/admin1.sign.key,./testdata/crypto-config/wx-org4.chainmaker.org/user/admin1/admin1.sign.key" \
--admin-sign-crts="./testdata/crypto-config/wx-org1.chainmaker.org/user/admin1/admin1.sign.crt,./testdata/crypto-config/wx-org2.chainmaker.org/user/admin1/admin1.sign.crt,./testdata/crypto-config/wx-org3.chainmaker.org/user/admin1/admin1.sign.crt,./testdata/crypto-config/wx-org4.chainmaker.org/user/admin1/admin1.sign.crt"
