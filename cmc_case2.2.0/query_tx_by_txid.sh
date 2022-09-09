cmc_path='../../chainmaker-go/tools/cmc'
cd ${cmc_path}
txid=$1
txid_default="f434558fc5764b30b83d9a1b29d8eea94d9c194897dd43cf8ba07d76ad05180f"
if [ -z "$txid" ];then
	txid=$txid_default
	echo $txid
else
	txid=$1
	echo $txid
fi
#echo $txid
./cmc query tx $txid \
--chain-id=chain1 \
--sdk-conf-path=./testdata/sdk_config.yml




