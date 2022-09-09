cmc_path='../../chainmaker-go/tools/cmc'
cd ${cmc_path}
CURRENT_PWD=$(pwd)
echo ${CURRENT_PWD}
block_height=$1
block_height_default=0
if [ -z "$block_height" ];then
        block_height=$block_height_default
else
        block_height=$1
fi
echo "-------------------------根据块高查询数据-------------------------------"

./cmc query block-by-height $block_height \
--chain-id=chain1 \
--sdk-conf-path=./testdata/sdk_config_pk.yml

#./cmc client contract user create \
#--contract-name=$contract_name \
#--runtime-type=WASMER \
#--byte-code-path=./testdata/claim-wasm-demo/rust-fact-2.0.0.wasm \
#--version=1.0 \
#--sdk-conf-path=./testdata/sdk_config_pk.yml \
#--admin-key-file-paths=./testdata/crypto-config/node1/admin/admin1/admin1.key \
#--sync-result=true \
#--params="{}"
#

