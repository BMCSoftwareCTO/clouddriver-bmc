#!/bin/sh

echo updating #APPNAME# shell script CLASSPATH
sed -i.bak -e '/CLASSPATH=\$CLASSPATH:#INSTALLPATH_ESCAPED#\/lib\/\*/d' -e s/"\(DEFAULT_JVM_OPTS=\)'\(.*\)\"\(\-Dspring\.config\.location=\)\(.*\)\(,#INSTALLPATH_ESCAPED#\\/config\\/\)\"'"/\\1\'\\2\"\\3\\4\"\'/ #SERVICE_INSTALLPATH#/bin/#APPNAME#
echo start #APPNAME# service
service #APPNAME# start
