#!/bin/sh

while IFS=";" read -r ftp_username ftp_userpass ftp_useruid
do
  [ ! -d "/home/$ftp_username" ] && mkdir -p "/home/$ftp_username"
  echo ${ftp_userpass} | /usr/local/proftpd/contrib/ftpasswd --stdin --passwd --file="${PROFTPD_PASSWD_FILE}" --name=${ftp_username} --uid=${USER_UID} --gid=${USER_GID} --home=/home/$ftp_username --shell=/sbin/nologin
  chown -R ${USER_UID}:${USER_GID} /home/$ftp_username
done < "/opt/userlist.csv"
envsubst < /etc/proftpd/proftpd.conf.template > /etc/proftpd/proftpd.conf

exec "$@"