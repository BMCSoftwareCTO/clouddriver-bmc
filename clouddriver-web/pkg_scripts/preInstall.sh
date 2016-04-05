#!/bin/bash

service=#APPNAME#

if (( $(ps -ef | grep -v grep | grep $service | wc -l) > 0 ))
then
  echo "$service is running"
  mkdir -p /tmp/bmc
  touch /tmp/bmc/$service
  service $service stop
fi
