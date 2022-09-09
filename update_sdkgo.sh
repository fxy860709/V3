# 8月27日发布2.0.0版本以后：将会把默认chainmaker.org映射到开源库中
# 前置条件:https://www.tapd.cn/47654106/markdown_wikis/show/#1147654106001000115@toc5
chainmakergo_path='../chainmaker-go'
sdkgo_path='../sdk-go'
cd ${sdkgo_path}
pwd
#go mod download
#go build
rm -rf ./testdata/crypto-config
cp -r ${chainmakergo_path}/build/crypto-config ./testdata/
# 根目录下生成cmc
#cd ${chainmakergo_path}
#make cmc
#echo 'cmc工具编译完成:/home/projects/test/chainmaker-go/bin'
