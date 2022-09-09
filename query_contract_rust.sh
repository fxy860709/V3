cmc_path='../chainmaker-go/tools/cmc'
cd ${cmc_path}
./cmc client contract user get \
--contract-name=fact \
--method=find_by_file_hash \
--sdk-conf-path=./testdata/sdk_config.yml \
--params="{\"file_hash\":\"ab3456df5799b87c77e7f88\"}"
