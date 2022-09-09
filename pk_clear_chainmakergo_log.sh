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
rm -rf chainmaker-*-node1/log/*
rm -rf chainmaker-*-node2/log/*
rm -rf chainmaker-*-node3/log/*
rm -rf chainmaker-*-node4/log/*
echo 'after clear log:'
du -sh
