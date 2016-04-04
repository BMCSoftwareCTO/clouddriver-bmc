#!/bin/sh

echo updating #APPNAME# shell script CLASSPATH
sed -i.bak -e s/"\(CLASSPATH=\\\$APP_HOME.*\)"/\\1\\nCLASSPATH=\$CLASSPATH:#INSTALLPATH_ESCAPED#\\/lib\\/\\*/ -e s/"\(DEFAULT_JVM_OPTS=\)'\(.*\)\"\(\-Dspring\.config\.location=\)\(.*\)\"'"/\\1\'\\2\"\\3\\4,#INSTALLPATH_ESCAPED#\\\/config\\/\"\'/ #SERVICE_INSTALLPATH#/bin/#APPNAME#
echo start #APPNAME# service
service #APPNAME# start
