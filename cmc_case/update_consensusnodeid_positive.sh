cmc_path='../../chainmaker-go/tools/cmc'
cd ${cmc_path}
./cmc client chainconfig consensusnodeid update \
--sdk-conf-path=./testdata/sdk_config.yml \
--admin-org-ids=wx-org1.chainmaker.org,wx-org2.chainmaker.org,wx-org3.chainmaker.org \
--admin-crt-file-paths=./testdata/crypto-config/wx-org1.chainmaker.org/user/admin1/admin1.tls.crt,./testdata/crypto-config/wx-org2.chainmaker.org/user/admin1/admin1.tls.crt,./testdata/crypto-config/wx-org3.chainmaker.org/user/admin1/admin1.tls.crt \
--admin-key-file-paths=./testdata/crypto-config/wx-org1.chainmaker.org/user/admin1/admin1.tls.key,./testdata/crypto-config/wx-org2.chainmaker.org/user/admin1/admin1.tls.key,./testdata/crypto-config/wx-org3.chainmaker.org/user/admin1/admin1.tls.key \
--node-id-old=QmXSLt3UDeo4Bj6Z2cMWWqFAsnd1xPDshLE7kzAsQe6MYs \
--node-id=QmdGSnb1Bk7vVfxrj5xJ4abXQmyWbaekJAsaTvBAtwq8Ug \
--node-org-id=wx-org1.chainmaker.org
# --node-id=QmdGSnb1Bk7vVfxrj5xJ4abXQmyWbaekJAsaTvBAtwq8Ug \
