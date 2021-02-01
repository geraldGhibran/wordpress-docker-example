# wordpress-docker-example
Build docker image
```
docker build -t wpadmin .
```

Run command below to build images using previous docker images

```
docker run -it -d --name wpadminapps -p 82:82 wpadmin

```

Setup database

```
mysql -u root
CREATE DATABASE wordpress CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
GRANT ALL ON wordpress.* TO 'username'@'localhost' IDENTIFIED BY 'password';
FLUSH PRIVILEGES;
```

Now, visit http://localhost:82 to try the demo.

## Notes

This repo is dockarized with this tutorial https://www.niagahoster.co.id/blog/cara-install-wordpress-menggunakan-nginx-di-ubuntu/ feel free to check that out if wordpress admin not running and give the star if this works for you, thanks.