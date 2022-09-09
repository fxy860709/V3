# 适用于cm与dockervm都在本机的情况
docker run -d -e ENV_LOG_IN_CONSOLE=true -p22351:22359 --network docker_localnet --ip 172.48.1.21 --privileged chainmakerofficial/chainmaker-vm-docker-go:v2.2.1
docker run -d -e ENV_LOG_IN_CONSOLE=true -p22352:22359 --network docker_localnet --ip 172.48.1.22 --privileged chainmakerofficial/chainmaker-vm-docker-go:v2.2.1
docker run -d -e ENV_LOG_IN_CONSOLE=true -p22353:22359  --network docker_localnet --ip 172.48.1.23 --privileged chainmakerofficial/chainmaker-vm-docker-go:v2.2.1
docker run -d -e ENV_LOG_IN_CONSOLE=true -p22354:22359 --network docker_localnet --ip 172.48.1.24 --privileged chainmakerofficial/chainmaker-vm-docker-go:v2.2.1
