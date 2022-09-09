new_path_org1=/home/projects/test/chainmaker-go/build/release/chainmaker-*-wx-org1.chainmaker.org/bin/chainmaker
old_path_org1=/home/projects/online/chainmaker-go/build/release/chainmaker-*-wx-org1.chainmaker.org/bin/
new_path_org2=/home/projects/test/chainmaker-go/build/release/chainmaker-*-wx-org2.chainmaker.org/bin/chainmaker
old_path_org2=/home/projects/online/chainmaker-go/build/release/chainmaker-*-wx-org2.chainmaker.org/bin/
new_path_org3=/home/projects/test/chainmaker-go/build/release/chainmaker-*-wx-org3.chainmaker.org/bin/chainmaker
old_path_org3=/home/projects/online/chainmaker-go/build/release/chainmaker-*-wx-org3.chainmaker.org/bin/
new_path_org4=/home/projects/test/chainmaker-go/build/release/chainmaker-*-wx-org4.chainmaker.org/bin/chainmaker
old_path_org4=/home/projects/online/chainmaker-go/build/release/chainmaker-*-wx-org4.chainmaker.org/bin/
rm -f "${old_path_org1}chainmaker"
rm -f "${old_path_org2}chainmaker"
rm -f "${old_path_org3}chainmaker"
rm -f "${old_path_org4}chainmaker"
cp ${new_path_org1} ${old_path_org1}
cp ${new_path_org2} ${old_path_org2}
cp ${new_path_org3} ${old_path_org3}
cp ${new_path_org4} ${old_path_org4}
