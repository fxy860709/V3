echo "把vm的日志节点设置为debug"
read -p "请输入要设置的node: (1=node1,2=node2,3=node3,4=node4):" num
#echo ${num}
#vim ../chainmaker-go/build/release/chainmaker-*-wx-org${num}.chainmaker.org/config/wx-org${num}.chainmaker.org/chainmaker.yml
chainmakeryml_path="../chainmaker-go/build/release/chainmaker-*-node${num}/config/node${num}"
cd ${chainmakeryml_path}
pwd
sed -i 's/log_level: INFO/log_level: DEBUG/g' chainmaker.yml
sed -i 's/core: INFO/core: DEBUG/g' log.yml

cat chainmaker.yml |grep "log_level"
cat log.yml |grep "core:"

