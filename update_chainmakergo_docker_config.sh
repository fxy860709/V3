cd ../chainmaker-go/scripts/docker/config/four-nodes
pwd
rm -rf ./*
cp -r ../../../../build/release/chainmaker-v2.2.1-wx-org1.chainmaker.org/config/wx-org1.chainmaker.org ./
cp -r ../../../../build/release/chainmaker-v2.2.1-wx-org2.chainmaker.org/config/wx-org2.chainmaker.org ./
cp -r ../../../../build/release/chainmaker-v2.2.1-wx-org3.chainmaker.org/config/wx-org3.chainmaker.org ./
cp -r ../../../../build/release/chainmaker-v2.2.1-wx-org4.chainmaker.org/config/wx-org4.chainmaker.org ./
