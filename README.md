# docker_nodejs

```
cd /Users/i830671/Documents/XSA/docker_nodejs
docker build --no-cache -t alunde/nodejs:latest .
docker build -t alunde/nodejs:latest .
echo "docker run -ti -p 8080:8080 alunde/nodejs:latest"
docker push alunde/nodejs:latest
cf delete docker_nodejs.dkr -f -r
cf push docker_nodejs.dkr --docker-image alunde/nodejs:latest -m 640M -k 2G -n docker-nodejs --no-start -u none
cf bs docker_nodejs.dkr docker-nodejs-uaa
cf bs docker_nodejs.dkr docker-mysqls-dbt
cf restage docker_nodejs.dkr
cf enable-ssh docker_nodejs.dkr
cf restart docker_nodejs.dkr
cf ssh docker_nodejs.dkr
```
Once you are shelled into the container, you can access the MySQL Sever through the Chisel Tunnel with this.
```
/usr/bin/mysql -u root -p -h 127.0.0.1 -P 3306 -D test -e "SELECT * FROM test.test2;"
Enter password: Nirvana8484
+----+----------+
| id | value    |
+----+----------+
|  1 | One      |
|  2 | Two      |
|  3 | Thareee! |
+----+----------+
```
