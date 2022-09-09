#CURRENT_PATH=$(pwd)
keys=$1
node_num=$2
if [ -z "$node_num" ];then
	read -p "请输入搜索关键字: " keys
        read -p "请输入节点(例如1): " node_num
fi
# echo $CURRENT_PATH
RELEASE_PATH='../chainmaker-go/build/release'
# echo $RELEASE_PATH
cd $RELEASE_PATH
#CURRENT_PATH=$(pwd)
#echo $CURRENT_PATH
echo $(pwd)
echo "-------------------org$node_num--------------------"
cat chainmaker-*$node_num*/log/system.log |grep "$keys"

