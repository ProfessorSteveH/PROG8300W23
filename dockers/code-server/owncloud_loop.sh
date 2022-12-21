#!/bin/bash

while [ 1 ]
do
  owncloudcmd -u $OC_USER -p $OC_PASS -s --non-interactive /shared http://$OC_IP
  sleep 15
done
