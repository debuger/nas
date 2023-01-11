#!/bin/sh

gid=100
GROUPNAME=proftpd

#create a group if not exists
# GRP=`cat "/etc/group-" | grep ":${gid}:"`
# if [[ ! -z $GRP ]]
# then
# 	GROUPNAME=`echo ${GRP} | cut -d ":" -f 1`
# else
# 	addgroup -g ${gid} ${GROUPNAME}
# fi

while IFS=";" read -r ftp_username ftp_userpass ftp_useruid
do
	adduser --shell /bin/sh -D -u ${ftp_useruid} -G users -h /home/$ftp_username $ftp_username
	addgroup $ftp_username proftpd
	echo "${ftp_username}:${ftp_userpass}" | chpasswd
  chown -R $ftp_username:${GROUPNAME} /home/$ftp_username
done < "/opt/userlist.csv"

# if [[ -z "${PASSIVE_MIN_PORT}" ]]; then
#   PASV_MIN=50000
# else
#   PASV_MIN="${PASSIVE_MIN_PORT}"
# fi
# if [[ -z "${PASSIVE_MAX_PORT}" ]]; then
#   PASV_MAX=50100
# else
#   PASV_MAX="${PASSIVE_MAX_PORT}"
# fi
# sed -i "s/^\(# \)\?PassivePorts.*$/PassivePorts ${PASV_MIN} ${PASV_MAX}/" /etc/proftpd/proftpd.conf

# if [[ -z "${MASQUERADE_ADDRESS}" ]]; then
#   sed -i "s/^\(# \)\?MasqueradeAddress.*$/# MasqueradeAddress x.x.x.x/" /etc/proftpd/proftpd.conf
# else
#   sed -i "s/^\(# \)\?MasqueradeAddress.*$/MasqueradeAddress ${MASQUERADE_ADDRESS}/" /etc/proftpd/proftpd.conf
# fi

exec "$@"