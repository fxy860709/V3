docker rm $(docker stop $(docker ps -a -q -f ancestor=$1))
