vmdockergo_version="v2.2.1_qc"
vmdockergo_path="../vm-docker-go"
#vmdockergo_version="v2.2.0_alpha_qc_docker_vm_service"
echo "本次构建的vm-docker-go分支名称":${vmdockergo_version}
cd ${vmdockergo_path}
git pull
git branch
git checkout ${vmdockergo_version}
make build-image
docker images
