path="../../../chainmaker-go/tools/cmc_cert/testdata/"
rm -rf ../../../chainmaker-go/tools/cmc_cert
cp -r ../../../chainmaker-go/tools/cmc ../../../chainmaker-go/tools/cmc_cert
cp ../*.json ../../../chainmaker-go/tools/cmc_cert/testdata/
cp ../*.7z ../../../chainmaker-go/tools/cmc_cert/testdata/docker-go-demo/
ls -al ../../../chainmaker-go/tools/cmc_cert/testdata |grep "json"
ls -al ../../../chainmaker-go/tools/cmc_cert/testdata/docker-go-demo
cd $path
pwd
sed -i "s/127.0.0.1:12301/172.21.48.7:12301/g" sdk_config.yml
sed -i "s/127.0.0.1:12302/172.21.48.3:12302/g" sdk_config.yml
cat sdk_config.yml |grep "addr"


