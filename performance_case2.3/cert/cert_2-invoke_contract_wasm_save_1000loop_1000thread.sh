cmc_path='../../../chainmaker-go/tools/cmc_cert'
cd ${cmc_path}
./cmc parallel invoke \
--loopNum=600  \
--printTime=5 \
--threadNum=2000 \
--timeout=1000 \
--sleepTime=20000 \
--climbTime=5  \
--use-tls=true \
--showKey=true \
--contract-name="fact" \
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
