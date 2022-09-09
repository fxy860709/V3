CURRENT_PATH=$(pwd)
# echo $CURRENT_PATH
#version="V1.0.0"
RELEASE_PATH='../chainmaker-go/build/release'
# echo $RELEASE_PATH
cd $RELEASE_PATH
CURRENT_PATH=$(pwd)
echo $CURRENT_PATH
echo $(pwd)
echo "-------------------node1--------------------"
cat chainmaker-*-node1/log/system.log* |grep "commit block"
echo "-------------------node2--------------------"
cat chainmaker-*-node2/log/system.log* |grep "commit block"
echo "-------------------node3--------------------"
cat chainmaker-*-node3/log/system.log* |grep "commit block"
echo "-------------------node4--------------------"
cat chainmaker-*-node4/log/system.log* |grep "commit block"

