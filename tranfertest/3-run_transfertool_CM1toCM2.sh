echo "build transfertool"
transfertool_path="../../chainmaker-transfer-tool"
cd $transfertool_path
#go build -gcflags "all=-N -l"
sleep 2
echo "设置迁移高度执行build"
cat ./config_path/dev/config.yml |grep "transfer_height"
go build
echo "拉取数据"
./transfer-tool
