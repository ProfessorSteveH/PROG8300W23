#!/bin/bash

while [ 1 ]
do
  owncloudcmd -u $OC_USER -p $OC_PASS --silent $HOME/local http://$OC_IP:8080
  sleep 60
done
