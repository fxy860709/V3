CURRENT_PATH=$(pwd)
# echo $CURRENT_PATH
RELEASE_PATH='../chainmaker-go/build/release'
# echo $RELEASE_PATH
cd $RELEASE_PATH
CURRENT_PATH=$(pwd)
echo $CURRENT_PATH
echo $(pwd)
echo 'before clear data:'
du -sh
rm -rf chainmaker-*-node1/data/*
rm -rf chainmaker-*-node2/data/*
rm -rf chainmaker-*-node3/data/*
rm -rf chainmaker-*-node4/data/*
echo 'after clear data:'
du -sh
