Extended HTPC
----
This repo used to build an HTPC based on host linux OS with Kodi as main launcher to extend it without breaking main functionality.

Should to know
----
It should work!

Should be mentioned
----
Some ideas was used from [notes' series on habr](https://habr.com/ru/post/548640/) [and one more article](https://habr.com/ru/company/timeweb/blog/645155/)

Certbot
----
docker-compose run --rm  certbot certonly --webroot -v --webroot-path /var/www/certbot/ --config-dir /var/www/certbot/config --logs-dir /var/log/letsencrypt/ --work-dir /var/www/certbot/work -d ${NGINX_HOST}

Docker images used:
-----
* [plex](https://hub.docker.com/r/linuxserver/plex)
* [nginx](https://hub.docker.com/_/nginx)
* [php](https://hub.docker.com/_/php)
* [nextcloud](https://hub.docker.com/_/nextcloud)
* [calibre-web](https://hub.docker.com/r/linuxserver/calibre-web)
* [mariadb](https://hub.docker.com/_/mariadb)
* [transmission](https://hub.docker.com/r/linuxserver/transmission)
* [alpine v3.15.4](https://hub.docker.com/_/alpine)

