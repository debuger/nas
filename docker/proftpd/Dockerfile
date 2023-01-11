FROM alpine:3.16.3

ENV PROFTPDUSR=${PROFTPDUSR:-proftpd} \
    PROFTPDGRP=${PROFTPDGRP:-proftpd} \
    PROFTPD_VERSION=${PROFTPD_VERSION:-1.3.8} \
    PROFTPDHOST=${PROFTPDHOST:-proftp} \
    PASSIVE_PORT_MIN=${PASSIVE_PORT_MIN:-65000} \
    PASSIVE_PORT_MAX=${PASSIVE_PORT_MAX:-65100} \
    USER_GID=${USER_GID:-100} \
    USER_GROUP=${USER_GROUP:-users}

ENV PROFTPD_DEPS \
  g++ \
  gcc \
  libc-dev \
  make

RUN set -x \
    && apk add --no-cache --virtual .persistent-deps \
        ca-certificates \
        curl \
        file \
    && apk add --no-cache --virtual .build-deps \
        $PROFTPD_DEPS \
    && apk add --no-cache --virtual .gettext gettext \
    && curl -fSL ftp://ftp.proftpd.org/distrib/source/proftpd-${PROFTPD_VERSION}.tar.gz -o proftpd.tgz \
    && tar -xf proftpd.tgz \
    && rm proftpd.tgz \
    && mkdir -p /usr/local \
    && mv proftpd-${PROFTPD_VERSION} /usr/local/proftpd \
    && sleep 1 \
    && cd /usr/local/proftpd \
    && sed -i 's/__mempcpy/mempcpy/g' lib/pr_fnmatch.c \
    && ./configure \
    && make \
    && cd /usr/local/proftpd && make install \
    && make clean \
    && apk del .build-deps

RUN echo "/sbin/nologin" >> /etc/shells
RUN addgroup ${PROFTPDGRP} && adduser -s /bin/sh -D -S -H ${PROFTPDUSR} ${PROFTPDGRP} \
    && mkdir /run/proftpd/ && chown -R ${PROFTPDUSR}:${PROFTPDGRP} /run/proftpd/ \
    && mkdir /opt/ftp/ && chown -R ${PROFTPDUSR}:${PROFTPDGRP} /opt/ftp/


ADD proftpd.conf.template /etc/proftpd/proftpd.conf.template
RUN envsubst < /etc/proftpd/proftpd.conf.template > /etc/proftpd/proftpd.conf && apk del .gettext
ADD docker-entrypoint.sh /usr/local/sbin/docker-entrypoint.sh
ADD userlist.csv /opt/userlist.csv

EXPOSE 20 21 ${PASSIVE_PORT_MIN}-${PASSIVE_PORT_MAX}

ENTRYPOINT ["/usr/local/sbin/docker-entrypoint.sh"]
VOLUME /opt/ftp/

CMD ["proftpd", "--nodaemon", "-c", "/etc/proftpd/proftpd.conf"]
