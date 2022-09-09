read -p "
[1]crypto_config_template.yml
[2]pkcs11_keys.yml
[3]chainmaker.tpl
[4]sdk_config.yml
输入要修改的文件序号:" num
if [ $num == 1 ];then
	vim ../../chainmaker-cryptogen/config/crypto_config_template.yml
elif [ $num == 2 ];then
	vim ../../chainmaker-cryptogen/config/pkcs11_keys.yml
elif [ $num == 3 ];then
	vim ../../chainmaker-go/config/config_tpl/chainmaker.tpl
elif [ $num == 4 ];then
	vim ../../chainmaker-go/tools/cmc/testdata/sdk_config.yml
fi
