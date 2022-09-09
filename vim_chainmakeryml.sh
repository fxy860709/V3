read -p "请输入要查看的org: (1=org1,2=org2,3=org3,4=org4):" num
echo ${num}
version="V1.0.0"
vim ../chainmaker-go/build/release/chainmaker-*-wx-org${num}.chainmaker.org/config/wx-org${num}.chainmaker.org/chainmaker.yml
