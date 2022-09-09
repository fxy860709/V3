read -p "
[1]crypto_config_template.yml
[2]pk_config_template.yml
[3]pwk_config_template.yml
[4]pkcs11_keys.yml
[5]chainmaker.tpl
[6]sdk_config.yml
[7]sdk_config_pk.yml
[8]sdk_config_pwk.yml
输入要修改的文件序号:" num
if [ $num == 1 ];then
	vim ../chainmaker-cryptogen/config/crypto_config_template.yml
elif [ $num == 2 ];then
	vim ../chainmaker-cryptogen/config/pk_config_template.yml
elif [ $num == 3 ];then
	vim ../chainmaker-cryptogen/config/pwk_config_template.yml
elif [ $num == 4 ];then
	vim ../chainmaker-cryptogen/config/pkcs11_keys.yml
elif [ $num == 5 ];then
	vim ../chainmaker-go/config/config_tpl/chainmaker.tpl
elif [ $num == 6 ];then
	vim ../chainmaker-go/tools/cmc/testdata/sdk_config.yml
elif [ $num == 7 ];then
	vim ../chainmaker-go/tools/cmc/testdata/sdk_config_pk.yml
elif [ $num == 8 ];then
	vim ../chainmaker-go/tools/cmc/testdata/sdk_config_pwk.yml
fi
