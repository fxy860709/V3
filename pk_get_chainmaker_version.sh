CURRENT_PATH=$(pwd)
# echo $CURRENT_PATH
RELEASE_PATH='../chainmaker-go/build/release'
# echo $RELEASE_PATH
cd $RELEASE_PATH
CURRENT_PATH=$(pwd)
echo $CURRENT_PATH
echo $(pwd)
echo "-------------------org1--------------------"
./chainmaker-*-node1/bin/chainmaker version |grep "ersion"
echo "-------------------org2--------------------"
./chainmaker-*-node2/bin/chainmaker version |grep "ersion"
echo "-------------------org3--------------------"
./chainmaker-*-node3/bin/chainmaker version |grep "ersion"
echo "-------------------org4--------------------"
./chainmaker-*-node4/bin/chainmaker version |grep "ersion"
