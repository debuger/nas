FROM nginx:1.27.2-alpine3.20

ENV C_UID ${CUSTOM_UID:-1}
ENV C_GID ${CUSTOM_GID:-1}
COPY nginx.conf /etc/nginx/nginx.conf

#RUN rm -rf /etc/nginx/conf.d/* && chown -R ${C_UID}:${C_GID} /etc/nginx/conf.d && chmod -R 0777 /var/cache/nginx
RUN chmod -R 0777 /var/cache/nginx && chmod -R 0777 /etc/nginx/conf.d/
RUN touch /var/run/nginx.pid && chmod -R 0777 /var/run/nginx.pid
