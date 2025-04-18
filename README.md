Extended HTPC
----
This repo used to build an HTPC based on host linux OS with Kodi as main launcher to extend it without breaking main functionality.

Should to know
----
It should work!

Should be mentioned
----
Some ideas was used from [notes' series on habr](https://habr.com/ru/post/548640/) [and one more article](https://habr.com/ru/company/timeweb/blog/645155/)

!!!
Configure plex transcoder to use folder `/transcode` as temporary.

!!!
Need to confirure HA to accept reverse proxy. [link](https://www.home-assistant.io/integrations/http) [link](https://community.home-assistant.io/t/reverse-proxy-using-nginx/196954)
with trusted IP of runing docker network

Services inclueded
----
* [plex](https://plex.tv/)
* [nginx](https://nginx.org/)
* [certbot](https://certbot.eff.org/)
* [php](https://www.php.net/)
* [nextcloud](https://nextcloud.com/)
* [calibre](https://calibre-ebook.com/)
* [mariadb](https://mariadb.org/)
* [hlsproxy](https://www.hls-proxy.com/)
* [xteve](https://github.com/xteve-project/xTeVe)
* [transmission](https://transmissionbt.com/)
* [proftp](http://www.proftpd.org/)
* [home assistant](https://home-assistant.io)
* [komga](https://komga.org/)
* [ollama](https://ollama.com/)
* [openwebui](https://docs.openwebui.com/)
* [minecraft](https://www.minecraft.net/)


Certbot
----
To generate sertificate run command 
```
docker-compose run --entrypoint /usr/local/bin/certbot certbot certonly -n --webroot -v --webroot-path /var/www/certbot/ --config-dir /var/www/certbot/config --logs-dir /var/log/letsencrypt/ --work-dir /var/www/certbot/work -d ${NGINX_HOST}
```
and update configs after result [see source](https://mindsers.blog/post/https-using-nginx-certbot-docker/)

On setup 
* rename all templates except `default` for nginx hosts to `.bak` in `docker/nginx/templates`
* run `www` service and exec `bin/certbot` to generate all certificates.
* shutdown `www` service
* rename templates back
* rebuild `www` service


Extra for KODI on host machine
-----
Check service `/usr/lib/systemd/system/kodi.service`


```
[Unit]
Description = Kodi Media Center (Started with xinit)
After = systemd-user-sessions.service network.target sound.target
Conflicts=getty@tty7.service

[Service]
User = nas
Group = users
Type = simple
TTYPath=/dev/tty7
ExecStart = /usr/bin/xinit /usr/bin/dbus-launch --exit-with-session /usr/bin/kodi-standalone -- :0 -nolisten tcp vt7
Restart = on-abort
RestartSec = 5
StandardInput = tty

[Install]
WantedBy = multi-user.target

```

Check permissions `/etc/permissions.local`

```
/usr/bin/Xorg root:root 0755
```

OPDS
----
* [Comics catalog](https://comics.${NGINX_HOST}/opds/v2/catalog)
* [Books catalog](https://calibre.${NGINX_HOST}/opds)

LLM
----
 docker-compose exec ollama ollama pull ilyagusev/saiga_llama3
 docker-compose exec ollama ollama pull llama3.1

Docker images used:
-----
* [plex](https://hub.docker.com/r/linuxserver/plex)
* [nginx](https://hub.docker.com/_/nginx)
* [php](https://hub.docker.com/_/php)
* [nextcloud](https://hub.docker.com/_/nextcloud)
* [calibre-web](https://hub.docker.com/r/linuxserver/calibre-web)
* [mariadb](https://hub.docker.com/_/mariadb)
* [transmission](https://hub.docker.com/r/linuxserver/transmission)
* [home assistant](https://hub.docker.com/r/homeassistant/home-assistant)
* [certbot](https://hub.docker.com/r/certbot/certbot)
* [komga](https://hub.docker.com/r/gotson/komga)
* [ollama](https://hub.docker.com/r/ollama/ollama)
* [alpine v3.20](https://hub.docker.com/_/alpine)
* [minecraft](https://github.com/itzg/docker-minecraft-server?tab=readme-ov-file)