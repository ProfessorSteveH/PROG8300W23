#!/bin/bash

while [ 1 ]
do
  owncloudcmd -u $OC_USER -p $OC_PASS --silent /home/prog8300  http://$OC_IP
  sleep 15
done
