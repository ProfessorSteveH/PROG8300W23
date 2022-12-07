#!/usr/bin/env bash

echo "starting 90-env.sh"

if [[ -f "/var/www/owncloud/config/config.php" ]]; then
        echo "checking for extra IP addresses for trusted networks"
        if [[ -z "${EXTRA_IP}" ]]; then
		echo "extra IP not set"
	else
                result=$(grep -i "${EXTRA_IP}" "/var/www/owncloud/config/config.php")
                if [[ -z "${result}" ]]; then
                        sed -i "s/'localhost',/'localhost','${EXTRA_IP}',/" config.php
                        echo "found and updated"
                fi
        fi
fi

if [ -f "/etc/entrypoint.d/prevIP" ]; then
	echo "checking previous IP against current IP"
	prevIP=$(</etc/entrypoint.d/prevIP)
	sed -i "s/'$prevIP'/'$EXTERNAL_IP'/g" /var/www/owncloud/config/config.php
fi

#sed -i "s/0 => 'localhost'/0 => 'localhost', 1 => '172.16.10.167'/g" /var/www/owncloud/config/config.php
export INT_IP=$(ip route get 172.17.0.1 | awk -F"src " 'NR==1{split($2,a," ");print a[1]}')
export OWNCLOUD_DOMAIN="localhost:80"
if [[ -z ${EXTRA_IP} ]]; then
	export OWNCLOUD_TRUSTED_DOMAINS="localhost,$EXTERNAL_IP,$INT_IP"
else
	export OWNCLOUD_TRUSTED_DOMAINS="localhost,$EXTERNAL_IP,$INT_IP,$EXTRA_IP"
fi
export OWNCLOUD_ADMIN_USERNAME="admin"
export OWNCLOUD_ADMIN_PASSWORD="p@ssw0rd"
export HTTP_PORT=80
export APACHE_LISTEN=80

echo $EXTERNAL_IP >  /etc/entrypoint.d/prevIP
#/etc/init.d/nginx start
