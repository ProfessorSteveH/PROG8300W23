#!/usr/bin/env bash

#sed -i "s/0 => 'localhost'/0 => 'localhost', 1 => '172.16.10.167'/g" /var/www/owncloud/config/config.php
export INT_IP=$(ip route get 172.17.0.1 | awk -F"src " 'NR==1{split($2,a," ");print a[1]}')
export OWNCLOUD_DOMAIN="localhost:80"
export OWNCLOUD_TRUSTED_DOMAINS="localhost,$EXTERNAL_IP,$INT_IP"
export OWNCLOUD_ADMIN_USERNAME="admin"
export OWNCLOUD_ADMIN_PASSWORD="p@ssw0rd"
export HTTP_PORT=80
export APACHE_LISTEN=80

#/etc/init.d/nginx start
