CURRENT_PATH=$(pwd)
# echo $CURRENT_PATH
RELEASE_PATH='../chainmaker-go/build/release'
# echo $RELEASE_PATH
cd $RELEASE_PATH
CURRENT_PATH=$(pwd)
version="V1.0.0"
echo $CURRENT_PATH
echo $(pwd)
echo 'before clear data:'
du -sh
rm -rf chainmaker-*-wx-org1.chainmaker.org/data/*
rm -rf chainmaker-*-wx-org2.chainmaker.org/data/*
rm -rf chainmaker-*-wx-org3.chainmaker.org/data/*
rm -rf chainmaker-*-wx-org4.chainmaker.org/data/*
echo 'after clear data:'
du -sh
