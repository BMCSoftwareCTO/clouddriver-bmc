#!/bin/bash
service=#APPNAME#

echo Updating $service shell script
sed -i.bak -e '/CLASSPATH=\$CLASSPATH:#INSTALLPATH_ESCAPED#\/lib\/\*/d' -e s/"\(DEFAULT_JVM_OPTS=\)'\(.*\)\"\(\-Dspring\.config\.location=\)\(.*\)\(,#INSTALLPATH_ESCAPED#\\/config\\/\)\"'"/\\1\'\\2\"\\3\\4\"\'/ #SERVICE_INSTALLPATH#/bin/$service

if [ -f "/tmp/bmc/$service" ]; then
  echo Restarting $service service
  rm -fr /tmp/bmc/$service
  service $service restart
fi
