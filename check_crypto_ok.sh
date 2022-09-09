#version="v2.1.0_qc"
read -p "请输入要查看的org: (1=org${num},2=org2,3=org3,4=org4):" num
# :%s/org${num}/org5/g
# release下链上生效的证书
node_cert="../chainmaker-go/build/release/chainmaker-*-wx-org${num}.chainmaker.org/config/wx-org${num}.chainmaker.org/certs/node/consensus1/consensus1.sign.crt"
node_key="../chainmaker-go/build/release/chainmaker-*-wx-org${num}.chainmaker.org/config/wx-org${num}.chainmaker.org/certs/node/consensus1/consensus1.sign.key"
node_nodeid="../chainmaker-go/build/release/chainmaker-*-wx-org${num}.chainmaker.org/config/wx-org${num}.chainmaker.org/certs/node/consensus1/consensus1.nodeid"
# prepares时生成的证书:
cryptoconfig_cert="../chainmaker-go/build/crypto-config/wx-org${num}.chainmaker.org/node/consensus1/consensus1.sign.crt"
cryptoconfig_key="../chainmaker-go/build/crypto-config/wx-org${num}.chainmaker.org/node/consensus1/consensus1.sign.key"
cryptoconfig_nodeid="../chainmaker-go/build/crypto-config/wx-org${num}.chainmaker.org/node/consensus1/consensus1.nodeid"
# cmc使用的证书:
cmc_cert="../chainmaker-go/tools/cmc/testdata/crypto-config/wx-org${num}.chainmaker.org/node/consensus1/consensus1.sign.crt"
cmc_key="../chainmaker-go/tools/cmc/testdata/crypto-config/wx-org${num}.chainmaker.org/node/consensus1/consensus1.sign.key"
cmc_nodeid="../chainmaker-go/tools/cmc/testdata/crypto-config/wx-org${num}.chainmaker.org/node/consensus1/consensus1.nodeid"
# sdk-go测试使用的证书
sdkgo_cert="../sdk-go/testdata/crypto-config/wx-org${num}.chainmaker.org/node/consensus1/consensus1.sign.crt"
sdkgo_key="../sdk-go/testdata/crypto-config/wx-org${num}.chainmaker.org/node/consensus1/consensus1.sign.key"
sdkgo_nodeid="../sdk-go/testdata/crypto-config/wx-org${num}.chainmaker.org/node/consensus1/consensus1.nodeid"
# docker部署时four-nodes下链上生效的证书
docker_node_cert="../chainmaker-go/scripts/docker/config/four-nodes/wx-org${num}.chainmaker.org/certs/node/consensus1/consensus1.sign.crt"
docker_node_key="../chainmaker-go/scripts/docker/config/four-nodes/wx-org${num}.chainmaker.org/certs/node/consensus1/consensus1.sign.key"
docker_node_nodeid="../chainmaker-go/scripts/docker/config/four-nodes/wx-org${num}.chainmaker.org/certs/node/consensus1/consensus1.nodeid"
echo "#########################证书md5##############################"
echo "release下链上生效的证书"
md5sum ${node_cert}
echo " "
echo "prepares时生成的证书"
md5sum ${cryptoconfig_cert}
echo " "
echo "cmc使用的证书"
md5sum ${cmc_cert}
echo " "
echo "sdkgo使用的证书"
md5sum ${sdkgo_cert}
echo " "
echo "docker部署使用的证书"
md5sum ${docker_node_cert}
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
echo "sdkgo使用的key"
cat ${sdkgo_key}
echo " "
echo "docker部署使用的key"
cat ${docker_node_key}
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
echo "sdkgo使用的nodeid"
cat ${sdkgo_nodeid}
echo " "
echo "docker部署使用的nodeid"
cat ${docker_node_nodeid}
echo " "
