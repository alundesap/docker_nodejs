# docker_nodejs

```
cd /Users/i830671/Documents/XSA/docker_nodejs
docker build --no-cache -t alunde/nodejs:latest .
docker build -t alunde/nodejs:latest .
echo "docker run -ti -p 8080:8080 alunde/nodejs:latest"
docker push alunde/nodejs:latest
cf delete nodejs -f -r
cf push nodejs --docker-image alunde/nodejs:latest -m 640M -k 2G -n mynodejs --no-start -u none
cf bs nodejs dat368-uaa
cf restage nodejs
cf enable-ssh nodejs
cf restart nodejs
cf ssh nodejs
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
