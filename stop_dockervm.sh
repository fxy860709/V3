docker rm $(docker stop $(docker ps -a -q -f ancestor=chainmakerofficial/chainmaker-vm-docker-go:v2.2.1))
#docker rm $(docker stop $(docker ps -a -q -f ancestor=chainmaker:v2.2.1))
