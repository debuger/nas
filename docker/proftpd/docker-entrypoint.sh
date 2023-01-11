#!/bin/sh

while IFS=";" read -r ftp_username ftp_userpass ftp_useruid
do
	adduser --shell /bin/sh -D -u ${ftp_useruid} -G users -h /home/$ftp_username $ftp_username
	addgroup $ftp_username ${PROFTPDGRP}
	echo "${ftp_username}:${ftp_userpass}" | chpasswd
  chown -R $ftp_username:${USER_GROUP} /home/$ftp_username
done < "/opt/userlist.csv"
envsubst < /etc/proftpd/proftpd.conf.template > /etc/proftpd/proftpd.conf

exec "$@"