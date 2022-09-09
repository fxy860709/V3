cd ../../chainmaker-go/tools/cmc
org1_addr=""
org2_addr=""
org3_addr=""
contract_name=asset_$(date "+%Y%m%d%H%M%S")

echo "=======================case9 started====================="
echo "合约名称为: ${contract_name}"
echo "***************创建合约*****************"
./cmc client contract user create \
--contract-name=${contract_name} \
--runtime-type=WASMER \
--byte-code-path=./testdata/asset-wasm-demo/rust-asset-2.1.0.wasm \
--version=1.0 \
--sdk-conf-path=./testdata/sdk_config.yml \
--admin-key-file-paths=./testdata/crypto-config/wx-org1.chainmaker.org/user/admin1/admin1.tls.key,./testdata/crypto-config/wx-org2.chainmaker.org/user/admin1/admin1.tls.key,./testdata/crypto-config/wx-org3.chainmaker.org/user/admin1/admin1.tls.key \
--admin-crt-file-paths=./testdata/crypto-config/wx-org1.chainmaker.org/user/admin1/admin1.tls.crt,./testdata/crypto-config/wx-org2.chainmaker.org/user/admin1/admin1.tls.crt,./testdata/crypto-config/wx-org3.chainmaker.org/user/admin1/admin1.tls.crt \
--params="{\"issue_limit\":\"100000000\",\"total_supply\":\"1000000000\"}" \
--sync-result=true
echo "Deployed contract successfully!"



echo "获取org1地址"
org1_addr=$(./cmc client contract user invoke \
--contract-name=${contract_name} \
--method=query_address \
--sdk-conf-path=./testdata/sdk_config.yml \
--params="" \
--sync-result=true)
org1_addr=${org1_addr#*result:\"}
org1_addr=${org1_addr%\" gas_used*}
echo ""
echo "***************创建org2新账号*****************"
./cmc client contract user invoke \
--contract-name=${contract_name} \
--method=register \
--sdk-conf-path=./testdata/sdk_config.yml \
--params="{}" \
--org-id="wx-org2.chainmaker.org" \
--user-signcrt-file-path=./testdata/crypto-config/wx-org2.chainmaker.org/user/client1/client1.sign.crt \
--user-signkey-file-path=./testdata/crypto-config/wx-org2.chainmaker.org/user/client1/client1.sign.key \
--sync-result=true
echo ""

org2_addr=$(./cmc client contract user invoke \
--contract-name=${contract_name} \
--method=query_address \
--sdk-conf-path=./testdata/sdk_config.yml \
--org-id="wx-org2.chainmaker.org" \
--user-signcrt-file-path=./testdata/crypto-config/wx-org2.chainmaker.org/user/client1/client1.sign.crt \
--user-signkey-file-path=./testdata/crypto-config/wx-org2.chainmaker.org/user/client1/client1.sign.key \
--params="" \
--sync-result=true)

org2_addr=${org2_addr#*result:\"}
org2_addr=${org2_addr%\" gas_used*}

echo "***************给org1账户颁发*****************"
echo "------向org1颁发100"
./cmc client contract user invoke \
--contract-name=${contract_name} \
--method=issue_amount \
--sdk-conf-path=./testdata/sdk_config.yml \
--params="{\"amount\":\"100\",\"to\":\"${org1_addr}\"}" \
--sync-result=true
echo "Issue amount 100 to org1 successfully"

echo "------向org2颁发100"
./cmc client contract user invoke \
--contract-name=${contract_name} \
--method=issue_amount \
--sdk-conf-path=./testdata/sdk_config.yml \
--params="{\"amount\":\"100\",\"to\":\"${org2_addr}\"}" \
--sync-result=true
echo "Issue amount 100 to org2 successfully"

echo "***************org1账户给org2账户转账10*****************"
./cmc client contract user invoke \
--contract-name=${contract_name} \
--method=transfer \
--sdk-conf-path=./testdata/sdk_config.yml \
--params="{\"amount\":\"10\",\"to\":\"${org2_addr}\"}" \
--sync-result=true
echo "transer 10 from org1 to org2 successfully"

echo "***************查询org1账户的余额*****************"
./cmc client contract user invoke \
--contract-name=${contract_name} \
--method=balance_of \
--sdk-conf-path=./testdata/sdk_config.yml \
--params="{\"owner\":\"${org1_addr}\"}" \
--sync-result=true


echo "***************查询org2账户的余额*****************"
./cmc client contract user invoke \
--contract-name=${contract_name} \
--method=balance_of \
--sdk-conf-path=./testdata/sdk_config.yml \
--params="{\"owner\":\"${org2_addr}\"}" \
--sync-result=true










