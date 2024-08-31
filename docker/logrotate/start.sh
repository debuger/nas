#!/bin/sh

LOGROTATE_LOGFILES="${LOGROTATE_LOGFILES:?Files for rotating must be given}"
LOGROTATE_FILESIZE="${LOGROTATE_FILESIZE:-10M}"
LOGROTATE_FILENUM="${LOGROTATE_FILENUM:-5}"
CRON_EXPR="${CRON_EXPR:?required!}"

cat > /var/logrotate.conf << EOF
${LOGROTATE_LOGFILES}
{
  size ${LOGROTATE_FILESIZE}
  missingok
  notifempty
  copytruncate
  rotate ${LOGROTATE_FILENUM}
  compress
}
EOF


echo "${CRON_EXPR} /usr/sbin/logrotate -v /var/logrotate.conf" >> /etc/crontabs/${G_NAME}

(crond -f -d 8) & CRONPID=$!
trap "kill $CRONPID; wait $CRONPID" SIGINT SIGTERM
wait $CRONPID