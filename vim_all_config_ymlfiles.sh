read -p "请输入要查看的org: (1=org1,2=org2,3=org3,4=org4):" num
echo ${num}
vim ../chainmaker-go/build/release/chainmaker-v2.0.0-wx-org${num}.chainmaker.org/config/wx-org${num}.chainmaker.org/chainmaker.yml
read -p "请输入要查看的bc: (1=bc1.yml) :" bc_num
vim ../chainmaker-go/build/release/chainmaker-v2.0.0-wx-org${num}.chainmaker.org/config/wx-org${num}.chainmaker.org/chainconfig/bc${bc_num}.yml
