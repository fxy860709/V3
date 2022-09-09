CURRENT_PATH=$(pwd)
# echo $CURRENT_PATH
#version="V1.0.0"
RELEASE_PATH='../chainmaker-go/build/release'
# echo $RELEASE_PATH
cd $RELEASE_PATH
CURRENT_PATH=$(pwd)
echo $CURRENT_PATH
echo $(pwd)
echo "-------------------org1--------------------"
cat chainmaker-*-wx-org1.chainmaker.org/log/system.log |grep "put block"
echo "-------------------org2--------------------"
cat chainmaker-*-wx-org2.chainmaker.org/log/system.log |grep "put block"
echo "-------------------org3--------------------"
cat chainmaker-*-wx-org3.chainmaker.org/log/system.log |grep "put block"
echo "-------------------org4--------------------"
cat chainmaker-*-wx-org4.chainmaker.org/log/system.log |grep "put block"

