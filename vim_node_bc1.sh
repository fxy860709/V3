echo "打开每个节点下的chainmaker.yml文件"
read -p "请输入要查看的org 或 node: (例如:1=org1/node1):" num
#echo ${num}
#vim ../chainmaker-go/build/release/chainmaker-*-wx-org${num}.chainmaker.org/config/wx-org${num}.chainmaker.org/chainmaker.yml
read -p "请输入要查看的bc: (1=bc1.yml) :" bc_num
vim ../chainmaker-go/build/release/chainmaker-*${num}*/config/*${num}*/chainconfig/bc${bc_num}.yml
