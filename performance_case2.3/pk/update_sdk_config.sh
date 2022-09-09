path="../../../chainmaker-go/tools/cmc_pk/testdata/"
cp ../*.json ../../../chainmaker-go/tools/cmc_pk/testdata/
cp ../*.7z ../../../chainmaker-go/tools/cmc_pk/testdata/docker-go-demo/
ls -al ../../../chainmaker-go/tools/cmc_pk/testdata |grep "json"
ls -al ../../../chainmaker-go/tools/cmc_pk/testdata/docker-go-demo
cd $path
pwd
sed -i "s/127.0.0.1:12301/172.21.48.7:12301/g" sdk_config_pk.yml
sed -i "s/127.0.0.1:12302/172.21.48.3:12302/g" sdk_config_pk.yml
cat sdk_config_pk.yml |grep "addr"


