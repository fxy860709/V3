read -p "请输入节点号:" num
new_version="/home/projects/test/chainmaker-go/build/release/chainmaker-*-wx-org${num}.chainmaker.org/bin"
old_version="/home/projects/online/chainmaker-go/build/release/chainmaker-*-wx-org${num}.chainmaker.org/bin"
echo "检查版本号:"
echo "新版本:"
$new_version/chainmaker version |grep Version
sleep 2
echo "旧版本:"
$old_version/chainmaker version |grep Version
echo "用新版替换旧版"
cd $old_version
mv chainmaker chainmaker_old
cp $new_version/chainmaker ./
echo "替换后旧版本是否升级:"
$old_version/chainmaker version |grep Version
