echo "清理上一次迁移产生的数据"
transfertool_path="../../chainmaker-transfer-tool"
cd "$transfertool_path"
pwd
rm -rf ../data/*
rm -rf ./sqlitedb/sqlite.db
ls -al ../data
ls -al ./sqlitedb
rm -f ./default.log*
rm -rf ./sdk.log*
