read -p "请输入节点号:" num
new_version=/home/projects/test/chainmaker-go/build/release/chainmaker-*-wx-org${num}.chainmaker.org/config/wx-org${num}.chainmaker.org
old_version=/home/projects/online/chainmaker-go/build/release/chainmaker-*-wx-org${num}.chainmaker.org/config/wx-org${num}.chainmaker.org
cd $old_version
pwd 
mv chainmaker.yml chainmaker_old.yml
cat chainmaker_old.yml |grep "/ip4"
cp $new_version/chainmaker.yml ./
read -p "复制替换seeds"
vim chainmaker.yml
