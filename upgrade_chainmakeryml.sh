
echo "替换"
new_path_org1="/home/projects/test/chainmaker-go/build/release/chainmaker-v2.1.0-wx-org1.chainmaker.org/config/wx-org1.chainmaker.org"
old_path_org1="/home/projects/online/chainmaker-go/build/release/chainmaker-v2.0.0-wx-org1.chainmaker.org/config/wx-org1.chainmaker.org"
new_path_org2="/home/projects/test/chainmaker-go/build/release/chainmaker-v2.1.0-wx-org2.chainmaker.org/config/wx-org2.chainmaker.org"
old_path_org2="/home/projects/online/chainmaker-go/build/release/chainmaker-v2.0.0-wx-org2.chainmaker.org/config/wx-org2.chainmaker.org"
new_path_org3="/home/projects/test/chainmaker-go/build/release/chainmaker-v2.1.0-wx-org3.chainmaker.org/config/wx-org3.chainmaker.org"
old_path_org3="/home/projects/online/chainmaker-go/build/release/chainmaker-v2.0.0-wx-org3.chainmaker.org/config/wx-org3.chainmaker.org"
new_path_org4="/home/projects/test/chainmaker-go/build/release/chainmaker-v2.1.0-wx-org4.chainmaker.org/config/wx-org4.chainmaker.org"
old_path_org4="/home/projects/online/chainmaker-go/build/release/chainmaker-v2.0.0-wx-org4.chainmaker.org/config/wx-org4.chainmaker.org"
mv "${old_path_org1}/chainmaker.yml" "${old_path_org1}/chainmaker_old.yml"
mv "${old_path_org2}/chainmaker.yml" "${old_path_org2}/chainmaker_old.yml"
mv "${old_path_org3}/chainmaker.yml" "${old_path_org3}/chainmaker_old.yml"
mv "${old_path_org4}/chainmaker.yml" "${old_path_org4}/chainmaker_old.yml"
cp "${new_path_org1}/chainmaker.yml" "${old_path_org1}/chainmaker.yml"
cp "${new_path_org2}/chainmaker.yml" "${old_path_org2}/chainmaker.yml"
cp "${new_path_org3}/chainmaker.yml" "${old_path_org3}/chainmaker.yml"
cp "${new_path_org4}/chainmaker.yml" "${old_path_org4}/chainmaker.yml"
echo "替换完成,需手动复制seeds的部分"
