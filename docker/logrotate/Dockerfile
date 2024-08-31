FROM alpine:3.20.2

ARG CUSTOM_UID
ARG CUSTOM_GID
ENV G_NAME=CROND

#RUN addgroup -g ${CUSTOM_GID} ${G_NAME}
RUN adduser -s /bin/sh -D -u ${CUSTOM_UID} ${G_NAME} ${G_NAME}

RUN apk --update add logrotate busybox-suid libcap dcron && \
	chown ${CUSTOM_UID}:${CUSTOM_GID} /usr/sbin/crond && \
	setcap cap_setgid=ep /usr/sbin/crond
RUN touch /var/logrotate.conf && \
	chown ${CUSTOM_UID}:${CUSTOM_GID} /var/logrotate.conf && \
	touch /etc/crontabs/${G_NAME} && \
	chown ${CUSTOM_UID}:${CUSTOM_GID} /etc/crontabs/${G_NAME} && \
	chown ${CUSTOM_UID}:${CUSTOM_GID} /var/lib
ADD start.sh /start.sh

USER ${G_NAME}
CMD ["/start.sh"]