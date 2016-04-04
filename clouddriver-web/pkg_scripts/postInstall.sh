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
sed -i.bak -e s/"\(CLASSPATH=\\\$APP_HOME.*\)"/\\1\\nCLASSPATH=\$CLASSPATH:#INSTALLPATH_ESCAPED#\\/lib\\/\\*/ -e s/"\(DEFAULT_JVM_OPTS=\)'\(.*\)\"\(\-Dspring\.config\.location=\)\(.*\)\"'"/\\1\'\\2\"\\3\\4,#INSTALLPATH_ESCAPED#\\\/config\\/\"\'/ #SERVICE_INSTALLPATH#/bin/$service

if [ "$isRunning" = "1" ]; then
  echo Restarting $service service
  service $service restart
fi
