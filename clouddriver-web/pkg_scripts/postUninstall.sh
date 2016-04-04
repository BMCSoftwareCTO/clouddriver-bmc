#!/bin/bash
service=#APPNAME#
isRunning=0

if (( $(ps -ef | grep -v grep | grep $service | wc -l) > 0 ))
then
  echo "$service is running"
  isRunning=1
else
  echo "$service is NOT running"
  isRunning=0
fi


echo Updating $service shell script
sed -i.bak -e '/CLASSPATH=\$CLASSPATH:#INSTALLPATH_ESCAPED#\/lib\/\*/d' -e s/"\(DEFAULT_JVM_OPTS=\)'\(.*\)\"\(\-Dspring\.config\.location=\)\(.*\)\(,#INSTALLPATH_ESCAPED#\\/config\\/\)\"'"/\\1\'\\2\"\\3\\4\"\'/ #SERVICE_INSTALLPATH#/bin/$service

if [ "$isRunning" = "1" ]; then
  echo Restarting $service service
  service $service restart
fi
