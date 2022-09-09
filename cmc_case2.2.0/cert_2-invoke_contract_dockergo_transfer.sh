cmc_path='../../chainmaker-go/tools/cmc'
cd ${cmc_path}
chainid="chain2"
user1_addr=""
user2_addr=""
register_user1(){
echo "-----------------注册user1------------------"
./cmc client contract user invoke \
--contract-name=fxy_transfer_dockervm2 \
--method=invoke_contract \
--sdk-conf-path=./testdata/sdk_config.yml \
--params="{\"method\":\"Register\"}" \
--chain-id=$chainid \
--sync-result=true
}
register_user2(){
echo "-----------------注册user2------------------"
./cmc client contract user invoke \
--contract-name=fxy_transfer_dockervm2 \
--method=invoke_contract \
--sdk-conf-path=./testdata/sdk_config3.yml \
--params="{\"method\":\"Register\"}" \
--chain-id=$chainid \
--sync-result=true
}
get_address_user1(){
echo "-----------------获取user1的地址------------------"
user1_addr=$(./cmc client contract user invoke \
--contract-name=fxy_transfer_dockervm2 \
--method=invoke_contract \
--sdk-conf-path=./testdata/sdk_config.yml \
--params="{\"method\":\"GetAddress\"}" \
--chain-id=$chainid \
--sync-result=true)
echo $user1_addr
user1_addr=${user1_addr#*result:\"}
echo $user1_addr
user1_addr=${user1_addr%\" message*}
echo $user1_addr
}
get_address_user2(){
echo "-----------------获取user2的地址------------------"
user2_addr=$(./cmc client contract user invoke \
--contract-name=fxy_transfer_dockervm2 \
--method=invoke_contract \
--sdk-conf-path=./testdata/sdk_config3.yml \
--params="{\"method\":\"GetAddress\"}" \
--chain-id=$chainid \
--sync-result=true)
user2_addr=${user2_addr#*result:\"}
user2_addr=${user2_addr%\" message*}
}
get_balance_user1(){
echo "-----------------获取user1 $user1_addr 的余额------------------"
./cmc client contract user invoke \
--contract-name=fxy_transfer_dockervm2 \
--method=invoke_contract \
--sdk-conf-path=./testdata/sdk_config.yml \
--params="{\"method\":\"BalanceOf\",\"address\":\"${user1_addr}\"}" \
--chain-id=$chainid \
--sync-result=true
}
get_balance_user2(){
echo "-----------------获取user2 $user2_addr 的余额------------------"
./cmc client contract user invoke \
--contract-name=fxy_transfer_dockervm2 \
--method=invoke_contract \
--sdk-conf-path=./testdata/sdk_config3.yml \
--params="{\"method\":\"BalanceOf\",\"address\":\"${user2_addr}\"}" \
--chain-id=$chainid \
--sync-result=true
}
issue_amount_user1(){
echo "-----------------向user1颁发金额------------------"
./cmc client contract user invoke \
--contract-name=fxy_transfer_dockervm2 \
--method=invoke_contract \
--sdk-conf-path=./testdata/sdk_config.yml \
--params="{\"method\":\"InitAmount\",\"to\":\"${user1_addr}\",\"amount\":\"300\"}" \
--chain-id=$chainid \
--sync-result=true
}
issue_amount_user2(){
echo "-----------------向user2颁发金额------------------"
./cmc client contract user invoke \
--contract-name=fxy_transfer_dockervm2 \
--method=invoke_contract \
--sdk-conf-path=./testdata/sdk_config.yml \
--params="{\"method\":\"InitAmount\",\"to\":\"${user2_addr}\",\"amount\":\"300\"}" \
--chain-id=$chainid \
--sync-result=true
}
transfer_user2_to_user1(){
echo "-----------------user2向user1转账------------------"
./cmc client contract user invoke \
--contract-name=fxy_transfer_dockervm2 \
--method=invoke_contract \
--sdk-conf-path=./testdata/sdk_config3.yml \
--params="{\"method\":\"Transfer\",\"to\":\"${user1_addr}\",\"amount\":\"20\"}" \
--chain-id=$chainid \
--sync-result=true
}
register_user1
register_user2
get_address_user1
get_balance_user1
get_address_user2
get_balance_user2
issue_amount_user1
issue_amount_user2
transfer_user2_to_user1
get_balance_user1
get_balance_user2
