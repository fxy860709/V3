num_node="1"
echo "更新证书目录:org"$num_node
ptf_crt_path="/mnt/datadisk0/ptf/docker_ver/test_env/chainmaker/chainmaker-wx-org${num_node}.chainmaker.org.consensus/config/wx-org${num_node}.chainmaker.org/"
chainmakergo_crt_path="/mnt/datadisk0/chainmaker-go/build/config/node${num_node}/*"
echo "目标路径:"$ptf_crt_path
echo "源路径:"$chainmakergo_crt_path
ptf_crt_path2="$ptf_crt_path*"
rm -rf $ptf_crt_path2
# sleep 10
cp -r $chainmakergo_crt_path $ptf_crt_path
md5sum /mnt/datadisk0/ptf/docker_ver/test_env/chainmaker/chainmaker-wx-org${num_node}.chainmaker.org.consensus/config/wx-org${num_node}.chainmaker.org/certs/ca/wx-org${num_node}.chainmaker.org/ca.crt

num_node="2"
echo "更新证书目录:org"$num_node
ptf_crt_path="/mnt/datadisk0/ptf/docker_ver/test_env/chainmaker/chainmaker-wx-org${num_node}.chainmaker.org.consensus/config/wx-org${num_node}.chainmaker.org/"
chainmakergo_crt_path="/mnt/datadisk0/chainmaker-go/build/config/node${num_node}/*"
echo "目标路径:"$ptf_crt_path
echo "源路径:"$chainmakergo_crt_path
ptf_crt_path2="$ptf_crt_path*"
rm -rf $ptf_crt_path2
cp -r $chainmakergo_crt_path $ptf_crt_path
md5sum /mnt/datadisk0/ptf/docker_ver/test_env/chainmaker/chainmaker-wx-org${num_node}.chainmaker.org.consensus/config/wx-org${num_node}.chainmaker.org/certs/ca/wx-org${num_node}.chainmaker.org/ca.crt

num_node="3"
echo "更新证书目录:org"$num_node
ptf_crt_path="/mnt/datadisk0/ptf/docker_ver/test_env/chainmaker/chainmaker-wx-org${num_node}.chainmaker.org.consensus/config/wx-org${num_node}.chainmaker.org/"
chainmakergo_crt_path="/mnt/datadisk0/chainmaker-go/build/config/node${num_node}/*"
echo "目标路径:"$ptf_crt_path
echo "源路径:"$chainmakergo_crt_path
ptf_crt_path2="$ptf_crt_path*"
rm -rf $ptf_crt_path2
cp -r $chainmakergo_crt_path $ptf_crt_path
md5sum /mnt/datadisk0/ptf/docker_ver/test_env/chainmaker/chainmaker-wx-org${num_node}.chainmaker.org.consensus/config/wx-org${num_node}.chainmaker.org/certs/ca/wx-org${num_node}.chainmaker.org/ca.crt

num_node="4"
echo "更新证书目录:org"$num_node
ptf_crt_path="/mnt/datadisk0/ptf/docker_ver/test_env/chainmaker/chainmaker-wx-org${num_node}.chainmaker.org.consensus/config/wx-org${num_node}.chainmaker.org/"
chainmakergo_crt_path="/mnt/datadisk0/chainmaker-go/build/config/node${num_node}/*"
echo "目标路径:"$ptf_crt_path
echo "源路径:"$chainmakergo_crt_path
ptf_crt_path2="$ptf_crt_path*"
rm -rf $ptf_crt_path2
cp -r $chainmakergo_crt_path $ptf_crt_path
md5sum /mnt/datadisk0/ptf/docker_ver/test_env/chainmaker/chainmaker-wx-org${num_node}.chainmaker.org.consensus/config/wx-org${num_node}.chainmaker.org/certs/ca/wx-org${num_node}.chainmaker.org/ca.crt

