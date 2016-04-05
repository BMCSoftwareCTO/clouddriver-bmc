#!/bin/bash
service=#APPNAME#
echo Updating $service shell script
sed -i.bak -e s/"\(CLASSPATH=\\\$APP_HOME.*\)"/\\1\\nCLASSPATH=\$CLASSPATH:#INSTALLPATH_ESCAPED#\\/lib\\/\\*/ -e s/"\(DEFAULT_JVM_OPTS=\)'\(.*\)\"\(\-Dspring\.config\.location=\)\(.*\)\"'"/\\1\'\\2\"\\3\\4,#INSTALLPATH_ESCAPED#\\\/config\\/\"\'/ #SERVICE_INSTALLPATH#/bin/$service

if [ -f "/tmp/bmc/$service" ]; then
  echo Restarting $service service
  rm -fr /tmp/bmc/$service
  service $service restart
fi
