echo "打开每个节点下的chainmaker.yml文件"
read -p "请输入要查看的org: (1=org1,2=org2,3=org3,4=org4):" num
#echo ${num}
#vim ../chainmaker-go/build/release/chainmaker-*-wx-org${num}.chainmaker.org/config/wx-org${num}.chainmaker.org/chainmaker.yml
read -p "请输入要查看的bc: (1=bc1.yml) :" bc_num
vim ../chainmaker-go/build/release/chainmaker-*-node${num}/config/node${num}/chainconfig/bc${bc_num}.yml
