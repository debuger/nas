FROM alpine:3.15.4

ENV PORT ${PROFTPD_PORT:-21}
ENV C_UID ${CUSTOM_UID:-100}
ENV C_GID ${CUSTOM_GID:-100}

ENV ALLOW_OVERWRITE=on \
    ANONYMOUS_DISABLE=off \
    ANON_UPLOAD_ENABLE=DenyAll \
    FTPUSER_PASSWORD_SECRET=ftp-user-password-secret \
    FTPUSER_NAME=ftpuser \
    FTPUSER_UID=${C_UID} \
    LOCAL_UMASK=022 \
    MAX_CLIENTS=2 \
    MAX_INSTANCES=10 \
    SERVER_NAME=ProFTPD \
    TIMES_GMT=off \
    TZ=UTC \
    WRITE_ENABLE=AllowAll




RUN apk update && apk upgrade
RUN apk add --no-cache proftpd
RUN mkdir /ftp

#RUN addgroup -S proftpd -g ${C_GID}
#RUN adduser -S proftpd -G proftpd -u ${C_UID}

#chown -R ${C_UID}:${C_GID} /etc/nginx/conf.d && chmod -R 0777 /var/cache/nginx


EXPOSE ${PORT}
#USER proftpd
COPY proftp.conf /etc/proftpd/proftpd.conf

ENTRYPOINT /usr/sbin/proftpd -n -c /etc/proftpd/proftpd.conf