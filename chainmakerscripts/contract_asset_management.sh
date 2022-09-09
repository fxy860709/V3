# 合约 contract_asset_management 使用命令脚本


org1_addr=""
org2_addr=""
org3_addr=""
contract_name="asset017"  

## 创建合约
echo "创建合约"
./cmc client contract user create \
--contract-name=${contract_name} \
--runtime-type=WASMER \
--byte-code-path=/mnt/d/develop/workspace/chainMaker/chainmaker-contract-sdk-rust/target/wasm32-unknown-unknown/release/chainmaker_contract.wasm \
--version=1.0 \
--params="{\"issue_limit\":\"1000000\",\"total_supply\":\"1000000000\",\"manager_pk\":\"\"}" \
--sdk-conf-path=./testdata/sdk_config.yml \
--admin-key-file-paths=./testdata/crypto-config/wx-org1.chainmaker.org/user/admin1/admin1.tls.key,./testdata/crypto-config/wx-org2.chainmaker.org/user/admin1/admin1.tls.key,./testdata/crypto-config/wx-org3.chainmaker.org/user/admin1/admin1.tls.key \
--admin-crt-file-paths=./testdata/crypto-config/wx-org1.chainmaker.org/user/admin1/admin1.tls.crt,./testdata/crypto-config/wx-org2.chainmaker.org/user/admin1/admin1.tls.crt,./testdata/crypto-config/wx-org3.chainmaker.org/user/admin1/admin1.tls.crt \
--sync-result=true
echo ""

## 获取默认用户(org1)地址
echo "获取org1地址"
org1_addr=$(./cmc client contract user get \
--contract-name=${contract_name} \
--method=query_address \
--sdk-conf-path=./testdata/sdk_config.yml \
--params="")
org1_addr=${org1_addr#*result:\"}
org1_addr=${org1_addr%\" gas_used*}
echo "org1_addr $org1_addr"
echo ""

## 注册org2账户
echo "注册org2账户"
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

## 获取org2账户地址
echo "获取org2地址"
org2_addr=$(./cmc client contract user get \
--contract-name=${contract_name} \
--method=query_address \
--sdk-conf-path=./testdata/sdk_config.yml \
--org-id="wx-org2.chainmaker.org" \
--user-signcrt-file-path=./testdata/crypto-config/wx-org2.chainmaker.org/user/client1/client1.sign.crt \
--user-signkey-file-path=./testdata/crypto-config/wx-org2.chainmaker.org/user/client1/client1.sign.key \
--params="")
org2_addr=${org2_addr#*result:\"}
org2_addr=${org2_addr%\" gas_used*}
echo "org2_addr $org2_addr"
echo ""

## 注册org3账户
echo "注册org3账户"
./cmc client contract user invoke \
--contract-name=${contract_name} \
--method=register \
--sdk-conf-path=./testdata/sdk_config.yml \
--params="{}" \
--org-id="wx-org3.chainmaker.org" \
--user-signcrt-file-path=./testdata/crypto-config/wx-org3.chainmaker.org/user/client1/client1.sign.crt \
--user-signkey-file-path=./testdata/crypto-config/wx-org3.chainmaker.org/user/client1/client1.sign.key \
--sync-result=true
echo ""

## 获取org3账户地址
echo "获取org3地址"
org3_addr=$(./cmc client contract user get \
--contract-name=${contract_name} \
--method=query_address \
--sdk-conf-path=./testdata/sdk_config.yml \
--org-id="wx-org3.chainmaker.org" \
--user-signcrt-file-path=./testdata/crypto-config/wx-org3.chainmaker.org/user/client1/client1.sign.crt \
--user-signkey-file-path=./testdata/crypto-config/wx-org3.chainmaker.org/user/client1/client1.sign.key \
--params="")
org3_addr=${org3_addr#*result:\"}
org3_addr=${org3_addr%\" gas_used*}
echo "org3_addr $org3_addr"
echo ""

## 给org1颁发代币
echo "给org1颁发代币100"
./cmc client contract user invoke \
--contract-name=${contract_name} \
--method=issue_amount \
--sdk-conf-path=./testdata/sdk_config.yml \
--params="{\"amount\":\"100\",\"to\":\"${org1_addr}\"}" \
--sync-result=true
echo ""

## 给org2颁发代币
echo "给org2颁发代币100"
./cmc client contract user invoke \
--contract-name=${contract_name} \
--method=issue_amount \
--sdk-conf-path=./testdata/sdk_config.yml \
--params="{\"amount\":\"100\",\"to\":\"${org2_addr}\"}" \
--sync-result=true
echo ""

## org1给org2转账
echo "org1给org2转账10"
./cmc client contract user invoke \
--contract-name=${contract_name} \
--method=transfer \
--sdk-conf-path=./testdata/sdk_config.yml \
--params="{\"amount\":\"10\",\"to\":\"${org2_addr}\"}" \
--sync-result=true
echo ""

## 查询org1的余额
echo "查询org1的余额"
./cmc client contract user get \
--contract-name=${contract_name} \
--method=balance_of \
--sdk-conf-path=./testdata/sdk_config.yml \
--params="{\"owner\":\"${org1_addr}\"}"
echo ""

## 查询org2的余额
echo "查询org2的余额"
./cmc client contract user get \
--contract-name=${contract_name} \
--method=balance_of \
--sdk-conf-path=./testdata/sdk_config.yml \
--params="{\"owner\":\"${org2_addr}\"}"
echo ""

## 查询org3的余额
echo "查询org3的余额"
./cmc client contract user get \
--contract-name=${contract_name} \
--method=balance_of \
--sdk-conf-path=./testdata/sdk_config.yml \
--params="{\"owner\":\"${org3_addr}\"}"
echo ""

## org2授权给org1代转账金额
echo "org2授权给org1代转账金额50"
./cmc client contract user invoke \
--contract-name=${contract_name} \
--method=approve \
--sdk-conf-path=./testdata/sdk_config.yml \
--org-id="wx-org2.chainmaker.org" \
--user-signcrt-file-path=./testdata/crypto-config/wx-org2.chainmaker.org/user/client1/client1.sign.crt \
--user-signkey-file-path=./testdata/crypto-config/wx-org2.chainmaker.org/user/client1/client1.sign.key \
--params="{\"amount\":\"50\",\"spender\":\"${org1_addr}\"}" \
--sync-result=true
echo ""

## org1用org2的钱给org3转账
echo "org1用org2的钱给org3转账5"
./cmc client contract user invoke \
--contract-name=${contract_name} \
--method=transfer_from \
--sdk-conf-path=./testdata/sdk_config.yml \
--params="{\"amount\":\"5\",\"from\":\"${org2_addr}\",\"to\":\"${org3_addr}\"}" \
--sync-result=true
echo ""

## 查询org2给org1授权的余额
echo "查询org2给org1授权的余额"
./cmc client contract user get \
--contract-name=${contract_name} \
--method=allowance \
--sdk-conf-path=./testdata/sdk_config.yml \
--params="{\"spender\":\"${org1_addr}\",\"owner\":\"${org2_addr}\"}"
echo ""

## org1和org2转账给org3
echo "org1和org2转账给org3 4,4"
./cmc client contract user invoke \
--contract-name=${contract_name} \
--method=transfer_multi \
--sdk-conf-path=./testdata/sdk_config.yml \
--params="{\"param\":\"[{\\\"amount\\\":4,\\\"from\\\":\\\"${org2_addr}\\\",\\\"to\\\":\\\"${org3_addr}\\\"}, {\\\"amount\\\":4,\\\"from\\\":\\\"${org1_addr}\\\",\\\"to\\\":\\\"${org3_addr}\\\"}]\"}" \
--sync-result=true
echo ""

## 查询org1的余额
echo "查询org1的余额"
./cmc client contract user get \
--contract-name=${contract_name} \
--method=balance_of \
--sdk-conf-path=./testdata/sdk_config.yml \
--params="{\"owner\":\"${org1_addr}\"}"
echo ""

## 查询org2的余额
echo "查询org2的余额"
./cmc client contract user get \
--contract-name=${contract_name} \
--method=balance_of \
--sdk-conf-path=./testdata/sdk_config.yml \
--params="{\"owner\":\"${org2_addr}\"}"
echo ""

## 查询org3的余额
echo "查询org3的余额"
./cmc client contract user get \
--contract-name=${contract_name} \
--method=balance_of \
--sdk-conf-path=./testdata/sdk_config.yml \
--params="{\"owner\":\"${org3_addr}\"}"
echo ""
