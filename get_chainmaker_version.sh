CURRENT_PATH=$(pwd)
# echo $CURRENT_PATH
RELEASE_PATH='../chainmaker-go/build/release'
# echo $RELEASE_PATH
cd $RELEASE_PATH
CURRENT_PATH=$(pwd)
echo $CURRENT_PATH
echo $(pwd)
echo "-------------------org1--------------------"
./chainmaker-*1*/bin/chainmaker version |grep "ersion"
echo "-------------------org2--------------------"
./chainmaker-*-*2*/bin/chainmaker version |grep "ersion"
echo "-------------------org3--------------------"
./chainmaker-*-*3*/bin/chainmaker version |grep "ersion"
echo "-------------------org4--------------------"
./chainmaker-*4*/bin/chainmaker version |grep "ersion"
