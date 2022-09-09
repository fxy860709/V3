cmc_path="../chainmaker-go/tools/cmc"
cd ${cmc_path}
pwd
rm -rf ./testdata/crypto-config
cp -rf ../../build/crypto-config ./testdata/
go mod tidy
#go mod download
go build

