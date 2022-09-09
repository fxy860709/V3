#version="V1.0.0"
#version="v2.1.0_qc"
read -p "请输入要查看的node: 1=node${num},2=2,3=node3,4=node4):" num
# :%s/node${num}/node5/g
# release下链上生效的证书
release_path="../chainmaker-go/build/release"
node_pem="../chainmaker-go/build/release/chainmaker-*-node${num}/config/node${num}/node${num}.pem"
node_key="../chainmaker-go/build/release/chainmaker-*-node${num}/config/node${num}/node${num}.key"
node_nodeid="../chainmaker-go/build/release/chainmaker-*-node${num}/config/node${num}/node${num}.nodeid"
node_admin_key="../chainmaker-go/build/release/chainmaker-*-node${num}/config/node${num}/admin/admin1/admin1.key"
# prepares时生成的证书:
cryptoconfig_pem="../chainmaker-go/build/crypto-config/node${num}/node${num}.pem"
cryptoconfig_key="../chainmaker-go/build/crypto-config/node${num}/node${num}.key"
cryptoconfig_nodeid="../chainmaker-go/build/crypto-config/node${num}/node${num}.nodeid"
cryptoconfig_admin_key="../chainmaker-go/build/crypto-config/node${num}/admin/admin1/admin1.key"
# cmc使用的证书:
cmc_pem="../chainmaker-go/tools/cmc/testdata/crypto-config/node${num}/node${num}.pem"
cmc_key="../chainmaker-go/tools/cmc/testdata/crypto-config/node${num}/node${num}.key"
cmc_nodeid="../chainmaker-go/tools/cmc/testdata/crypto-config/node${num}/node${num}.nodeid"
cmc_admin_key="../chainmaker-go/tools/cmc/testdata/crypto-config/node${num}/admin/admin1/admin1.key"
# sdk-go测试使用的证书
#sdkgo_cert="../sdk-go/testdata/crypto-config/wx-node${num}.chainmaker.node/node/consensus1/consensus1.sign.crt"
#sdkgo_key="../sdk-go/testdata/crypto-config/wx-node${num}.chainmaker.node/node/consensus1/consensus1.sign.key"
#sdkgo_nodeid="../sdk-go/testdata/crypto-config/wx-node${num}.chainmaker.node/node/consensus1/consensus1.nodeid"
echo "#########################证书md5##############################"
echo "release下链上生效的证书"
md5sum ${node_pem}
echo " "
echo "prepares时生成的证书"
md5sum ${cryptoconfig_pem}
echo " "
echo "cmc使用的证书"
md5sum ${cmc_pem}
echo " "
#echo "sdkgo使用的证书"
#md5sum ${sdkgo_cert}
echo "######################### key ##############################"
echo " "
echo "release下链上生效的key"
cat ${node_key}
echo " "
echo "prepare时生成的key"
cat ${cryptoconfig_key}
echo " "
echo "cmc使用的key"
cat ${cmc_key}
echo " "
#echo "sdkgo使用的key"
#cat ${sdkgo_key}
echo " "
echo "######################### nodeid ##############################"
echo "release下链上生效的nodeid"
cat ${node_nodeid}
echo " "
echo "prepare时生成的nodeid"
cat ${cryptoconfig_nodeid}
echo " "
echo "cmc目录下的nodeid"
cat ${cmc_nodeid}
echo " "
#echo "sdkgo使用的nodeid"
#cat ${sdkgo_nodeid}
#echo " "
echo "########################admin_key md5##############################"
echo "release下链上生效的admin.key"
md5sum ${node_admin_key}
echo " "
echo "prepares时生成的admin.key"
md5sum ${cryptoconfig_admin_key}
echo " "
echo "cmc使用的admin.key"
md5sum ${cmc_admin_key}
echo " "
