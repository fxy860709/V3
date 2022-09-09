chainid="chain1"
user1_addr=""
user2_addr=""
register_user1(){
echo "-----------------注册user1------------------"
./cmc client contract user invoke \
--contract-name=fxy_transfer_dockervm2 \
--method=invoke_contract \
--sdk-conf-path=./testdata/sdk_config_pk.yml \
--params="{\"method\":\"Register\"}" \
--chain-id=$chainid \
--sync-result=true
}
register_user2(){
echo "-----------------注册user2------------------"
./cmc client contract user invoke \
--contract-name=fxy_transfer_dockervm2 \
--method=invoke_contract \
--sdk-conf-path=./testdata/sdk_config_pk3.yml \
--params="{\"method\":\"Register\"}" \
--chain-id=$chainid \
--sync-result=true
}
get_address_user1(){
echo "-----------------获取user1的地址------------------"
user1_addr=$(./cmc client contract user invoke \
--contract-name=fxy_transfer_dockervm2 \
--method=invoke_contract \
--sdk-conf-path=./testdata/sdk_config_pk.yml \
--params="{\"method\":\"GetAddress\"}" \
--chain-id=$chainid \
--sync-result=true)
user1_addr=${addr1#*result:\"}
user1_addr=${addr1%\" gas_used*}
}
get_address_user3(){
echo "-----------------获取user2的地址------------------"
user2_addr=$(./cmc client contract user invoke \
--contract-name=fxy_transfer_dockervm2 \
--method=invoke_contract \
--sdk-conf-path=./testdata/sdk_config_pk3.yml \
--params="{\"method\":\"GetAddress\"}" \
--chain-id=$chainid \
--sync-result=true)
user2_addr=${addr1#*result:\"}
user2_addr=${addr1%\" gas_used*}
}
get_balance_user1(){
echo "-----------------获取user1的余额------------------"
./cmc client contract user invoke \
--contract-name=fxy_transfer_dockervm2 \
--method=invoke_contract \
--sdk-conf-path=./testdata/sdk_config_pk.yml \
--params="{\"method\":\"BalanceOf\",\"address\":\"1091454368760045686728293715997131471366494537677\"}" \
--chain-id=$chainid \
--sync-result=true
}
get_balance_user3(){
echo "-----------------获取user2的余额------------------"
./cmc client contract user invoke \
--contract-name=fxy_transfer_dockervm2 \
--method=invoke_contract \
--sdk-conf-path=./testdata/sdk_config_pk3.yml \
--params="{\"method\":\"BalanceOf\",\"address\":\"1091454368760045686728293715997131471366494537677\"}" \
--chain-id=$chainid \
--sync-result=true
}
issue_amount_user1(){
./cmc client contract user invoke \
--contract-name=fxy_transfer_dockervm2 \
--method=invoke_contract \
--sdk-conf-path=./testdata/sdk_config_pk.yml \
--params="{\"method\":\"InitAmount\",\"to\":\"${user1_addr}\",\"amount\":\"300\"}" \
--chain-id=$chainid \
--sync-result=true
}
issue_amount_user1(){
./cmc client contract user invoke \
--contract-name=fxy_transfer_dockervm2 \
--method=invoke_contract \
--sdk-conf-path=./testdata/sdk_config_pk.yml \
--params="{\"method\":\"InitAmount\",\"to\":\"${user2_addr}\",\"amount\":\"300\"}" \
--chain-id=$chainid \
--sync-result=true
}
transfer_user2_to_user1(){
./cmc client contract user invoke \
--contract-name=fxy_transfer_dockervm2 \
--method=invoke_contract \
--sdk-conf-path=./testdata/sdk_config_pk3.yml \
--params="{\"method\":\"Transfer\",\"to\":\"${user1_addr}\",\"amount\":\"20\"}" \
--chain-id="chain2" \
--sync-result=true
}
