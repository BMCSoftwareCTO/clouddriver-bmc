#!/bin/sh

echo updating #APPNAME# shell script CLASSPATH
sed -i.bak '/CLASSPATH=\$CLASSPATH:#INSTALLPATH_ESCAPED#\/config:#INSTALLPATH_ESCAPED#\/lib\/\*/d' #SERVICE_INSTALLPATH#/bin/#APPNAME#
echo start #APPNAME# service
service #APPNAME# start