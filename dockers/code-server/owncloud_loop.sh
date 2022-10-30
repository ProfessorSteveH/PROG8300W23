#!/bin/bash

while [ 1 ]
do
  owncloudcmd -u $OC_USER -p $OC_PASS --silent /shared http://$OC_IP
  sleep 15
done
