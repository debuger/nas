FROM nginx:1.19.6-alpine

ENV C_UID ${CUSTOM_UID:-1}
ENV C_GID ${CUSTOM_GID:-1}

RUN chmod -R 0777 /var/cache/nginx
RUN touch /var/run/nginx.pid && chmod -R 0777 /var/run/nginx.pid
