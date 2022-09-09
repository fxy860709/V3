CURRENT_PATH=$(pwd)
# echo $CURRENT_PATH
RELEASE_PATH='../chainmaker-go/build/release'
# echo $RELEASE_PATH
cd $RELEASE_PATH
version="V1.0.0"
echo $(pwd)
echo 'before clear log:'
du -sh 
#      chainmaker-*-wx-org2.chainmaker.org
rm -rf chainmaker-*-wx-org1.chainmaker.org/log/*
rm -rf chainmaker-*-wx-org2.chainmaker.org/log/*
rm -rf chainmaker-*-wx-org3.chainmaker.org/log/*
rm -rf chainmaker-*-wx-org4.chainmaker.org/log/*
echo 'after clear log:'
du -sh
