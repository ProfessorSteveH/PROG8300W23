#!/usr/bin/env bash

if [ -f "/etc/entrypoint.d/prevIP" ]; then
	prevIP=$(</etc/entrypoint.d/prevIP)
	sed -i "s/'$prevIP'/'$EXTERNAL_IP'/g" /var/www/owncloud/config/config.php
fi

#sed -i "s/0 => 'localhost'/0 => 'localhost', 1 => '172.16.10.167'/g" /var/www/owncloud/config/config.php
export INT_IP=$(ip route get 172.17.0.1 | awk -F"src " 'NR==1{split($2,a," ");print a[1]}')
export OWNCLOUD_DOMAIN="localhost:80"
export OWNCLOUD_TRUSTED_DOMAINS="localhost,$EXTERNAL_IP,$INT_IP"
export OWNCLOUD_ADMIN_USERNAME="admin"
export OWNCLOUD_ADMIN_PASSWORD="p@ssw0rd"
export HTTP_PORT=80
export APACHE_LISTEN=80

echo $EXTERNAL_IP >  /etc/entrypoint.d/prevIP
#/etc/init.d/nginx start
