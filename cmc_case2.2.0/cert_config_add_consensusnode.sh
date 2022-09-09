cmc_path='../../chainmaker-go/tools/cmc'

cd ${cmc_path}
read -p "请输入要加入共识的org: (1,2,3,4): " num
read -p "请输入组织[org${num}]里成为共识节点的nodeid: " consensus_nodeid
./cmc client chainconfig consensusnodeorg add \
--sdk-conf-path=./testdata/sdk_config.yml \
--org-id=wx-org1.chainmaker.org \
--user-tlscrt-file-path=./testdata/crypto-config/wx-org1.chainmaker.org/user/client1/client1.tls.crt \
--user-tlskey-file-path=./testdata/crypto-config/wx-org1.chainmaker.org/user/client1/client1.tls.key \
--user-signcrt-file-path=./testdata/crypto-config/wx-org1.chainmaker.org/user/client1/client1.sign.crt \
--user-signkey-file-path=./testdata/crypto-config/wx-org1.chainmaker.org/user/client1/client1.sign.key \
--admin-crt-file-paths=./testdata/crypto-config/wx-org1.chainmaker.org/user/admin1/admin1.tls.crt,./testdata/crypto-config/wx-org2.chainmaker.org/user/admin1/admin1.tls.crt,./testdata/crypto-config/wx-org3.chainmaker.org/user/admin1/admin1.tls.crt \
--admin-key-file-paths=./testdata/crypto-config/wx-org1.chainmaker.org/user/admin1/admin1.tls.key,./testdata/crypto-config/wx-org2.chainmaker.org/user/admin1/admin1.tls.key,./testdata/crypto-config/wx-org3.chainmaker.org/user/admin1/admin1.tls.key \
--node-ids=${consensus_nodeid} \
--node-org-id=wx-org${num}.chainmaker.org

