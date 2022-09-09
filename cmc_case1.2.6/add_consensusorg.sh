cmc_path='../../chainmaker-go/tools/cmc'
cd ${cmc_path}
./cmc client chainconfig consensusnodeorg add \
--sdk-conf-path=./testdata/sdk_config.yml \
--admin-org-ids=wx-org1.chainmaker.org,wx-org2.chainmaker.org,wx-org3.chainmaker.org \
--admin-crt-file-paths=./testdata/crypto-config/wx-org1.chainmaker.org/user/admin1/admin1.tls.crt,./testdata/crypto-config/wx-org2.chainmaker.org/user/admin1/admin1.tls.crt,./testdata/crypto-config/wx-org3.chainmaker.org/user/admin1/admin1.tls.crt \
--admin-key-file-paths=./testdata/crypto-config/wx-org1.chainmaker.org/user/admin1/admin1.tls.key,./testdata/crypto-config/wx-org2.chainmaker.org/user/admin1/admin1.tls.key,./testdata/crypto-config/wx-org3.chainmaker.org/user/admin1/admin1.tls.key \
--node-ids=QmXSLt3UDeo4Bj6Z2cMWWqFAsnd1xPDshLE7kzAsQe6MYs,QmduLw783zPH3mssbmiJX5Drv7XdMa8D8FCL7CJ7mbkZii,QmTtykrYviAnSakZTefdj4qLAusMLuCQ7H3Brx3TD9cxke,QmUzB8K6qrdL73VDdda162MCY9bWjA2H6X7FR91v86o8o8 \
--node-org-id=wx-org5.chainmaker.org
