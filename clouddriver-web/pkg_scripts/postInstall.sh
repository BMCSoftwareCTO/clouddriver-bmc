#!/bin/sh

echo updating #APPNAME# shell script CLASSPATH
sed -i.bak s/"\(CLASSPATH=\\\$APP_HOME.*\)"/\\1\\nCLASSPATH=\$CLASSPATH:#INSTALLPATH_ESCAPED#\\/config:#INSTALLPATH_ESCAPED#\\/lib\\/\\*/ #SERVICE_INSTALLPATH#/bin/#APPNAME#
echo start #APPNAME# service
service #APPNAME# start