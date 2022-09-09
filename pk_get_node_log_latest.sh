#CURRENT_PATH=$(pwd)
keys=$1
# echo $CURRENT_PATH
#version="V1.0.0"
RELEASE_PATH='../chainmaker-go/build/release'
# echo $RELEASE_PATH
cd $RELEASE_PATH
#CURRENT_PATH=$(pwd)
#echo $CURRENT_PATH
echo $(pwd)
echo "-------------------org1--------------------"
cat chainmaker-*-node1/log/system.log |grep "$1"
echo "-------------------org2--------------------"
cat chainmaker-*-node2/log/system.log |grep "$1"
echo "-------------------org3--------------------"
cat chainmaker-*-node3/log/system.log |grep "$1"
echo "-------------------org4--------------------"
cat chainmaker-*-node4/log/system.log |grep "$1"

