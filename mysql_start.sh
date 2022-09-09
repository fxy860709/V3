docker stop mysql
docker run --name mysql --rm -e MYSQL_ROOT_PASSWORD=password -p 3306:3306 -d mysql:5.7
docker ps -a
# docker exec -it mysql bash
# mysql -u root -p
# show databases;
# use blockdb_chain1
