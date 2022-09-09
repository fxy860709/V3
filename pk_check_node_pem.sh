transfertool_path="../chainmaker-transfer-tool"
chainmaker_path="../chainmaker-go/build/release"
read -p "请输入要查看的org: (1=org1,2=org2,3=org3,4=org4):" num
echo "-------------node1_admin_pem------------"
#num=1
md5sum $chainmaker_path/chainmaker-*-node${num}/config/node${num}/admin/admin1/admin1.pem
md5sum $chainmaker_path/chainmaker-*-node${num}/config/node${num}/admin/admin2/admin2.pem
md5sum $chainmaker_path/chainmaker-*-node${num}/config/node${num}/admin/admin3/admin3.pem
md5sum $chainmaker_path/chainmaker-*-node${num}/config/node${num}/admin/admin4/admin4.pem
echo "--------------transfertool_pem----------"
md5sum $transfertool_path/config_path/node1/admin/admin1/admin1.pem
md5sum $transfertool_path/config_path/node1/admin/admin2/admin2.pem
md5sum $transfertool_path/config_path/node1/admin/admin3/admin3.pem
md5sum $transfertool_path/config_path/node1/admin/admin4/admin4.pem
