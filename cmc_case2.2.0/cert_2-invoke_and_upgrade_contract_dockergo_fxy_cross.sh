echo "----主合约升级-----"
./cmc client contract user upgrade \
--contract-name=fxy_dockervm \
--runtime-type=DOCKER_GO \
--byte-code-path=./testdata/docker-go-demo/fxy_dockervm.7z \
--version=1.0 \
--sdk-conf-path=./testdata/sdk_config.yml \
--admin-key-file-paths=./testdata/crypto-config/wx-org1.chainmaker.org/user/admin1/admin1.tls.key,./testdata/crypto-config/wx-org2.chainmaker.org/user/admin1/admin1.tls.key,./testdata/crypto-config/wx-org3.chainmaker.org/user/admin1/admin1.tls.key,./testdata/crypto-config/wx-org4.chainmaker.org/user/admin1/admin1.tls.key \
--admin-crt-file-paths=./testdata/crypto-config/wx-org1.chainmaker.org/user/admin1/admin1.tls.crt,./testdata/crypto-config/wx-org2.chainmaker.org/user/admin1/admin1.tls.crt,./testdata/crypto-config/wx-org3.chainmaker.org/user/admin1/admin1.tls.crt,./testdata/crypto-config/wx-org4.chainmaker.org/user/admin1/admin1.tls.crt \
--sync-result=true \
--params="{}"

echo "----被调合约单独执行invoke--------"
./cmc client contract user invoke \
--contract-name=contract_fact \
--method=invoke_contract \
--sdk-conf-path=./testdata/sdk_config.yml \
--sync-result=true \
--params="{\"method\":\"save\",\"file_name\":\"name007\",\"file_hash\":\"ab3456df5799b87c77e7f88\",\"time\":\"6543234\"}"

echo "-----被调合约单独 执行 get--------"
./cmc client contract user get \
--contract-name=contract_fact \
--method=invoke_contract \
--sdk-conf-path=./testdata/sdk_config.yml \
--params="{\"method\":\"findByFileHash\",\"file_hash\":\"ab3456df5799b87c77e7f88\"}"

echo "-----被调合约升级--------"
./cmc client contract user upgrade \
--contract-name=contract_fact \
--runtime-type=DOCKER_GO \
--byte-code-path=./testdata/docker-go-demo/contract_fact.7z \
--version=1.0 \
--sdk-conf-path=./testdata/sdk_config.yml \
--admin-key-file-paths=./testdata/crypto-config/wx-org1.chainmaker.org/user/admin1/admin1.tls.key,./testdata/crypto-config/wx-org2.chainmaker.org/user/admin1/admin1.tls.key,./testdata/crypto-config/wx-org3.chainmaker.org/user/admin1/admin1.tls.key,./testdata/crypto-config/wx-org4.chainmaker.org/user/admin1/admin1.tls.key \
--admin-crt-file-paths=./testdata/crypto-config/wx-org1.chainmaker.org/user/admin1/admin1.tls.crt,./testdata/crypto-config/wx-org2.chainmaker.org/user/admin1/admin1.tls.crt,./testdata/crypto-config/wx-org3.chainmaker.org/user/admin1/admin1.tls.crt,./testdata/crypto-config/wx-org4.chainmaker.org/user/admin1/admin1.tls.crt \
--sync-result=true \
--params="{}"

echo "-----通过主调合约执行查询操作-----"
./cmc client contract user invoke \
--contract-name=fxy_dockervm \
--method=invoke_contract \
--sdk-conf-path=./testdata/sdk_config.yml \
--sync-result=true \
--params="{\"method\":\"cross_contract\",\"contract_name\":\"contract_fact\",\"contract_version\":\"1.0\",\"contract_method\":\"findByFileHash\",\"file_hash\":\"ab3456df5799b87c77e7f88\"}"


echo "-----通过主调合约执行存证操作------"
./cmc client contract user invoke \
--contract-name=fxy_dockervm \
--method=invoke_contract \
--sdk-conf-path=./testdata/sdk_config.yml \
--sync-result=true \
--params="{\"method\":\"cross_contract\",\"contract_name\":\"contract_fact\",\"contract_version\":\"1.0\",\"contract_method\":\"save\",\"file_name\":\"newname007\",\"file_hash\":\"ab3456df5799b87c77e7f88\",\"time\":\"6543234\"}"

