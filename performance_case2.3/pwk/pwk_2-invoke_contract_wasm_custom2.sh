cmc_path='../../../chainmaker-go/tools/cmc_pwk'
cd ${cmc_path}
pwd
./cmc parallel invoke \
--loopNum=600 \
--printTime=5 \
--threadNum=$1 \
--timeout=1000 \
--sleepTime=1000 \
--climbTime=5 \
--use-tls=false \
--auth-type=2 \
--showKey=false \
--contract-name="fact" \
--method="save" \
--pairs="" \
--pairs-file="./testdata/save.json" \
--org-IDs="wx-org1.chainmaker.org" \
--hosts="172.21.48.3:12302" \
--output-result=false \
--user-keys="./testdata/crypto-config/wx-org1.chainmaker.org/admin/admin.key" 
