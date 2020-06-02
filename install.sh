#!/bin/bash

GCPCSP_HOME=/opt/gcpcsp

echo "Downloading cloud_sql_proxy to $GCPCSP_HOME." 
mkdir -p $GCPCSP_HOME
wget -O $GCPCSP_HOME/cloud_sql_proxy https://dl.google.com/cloudsql/cloud_sql_proxy.linux.amd64
chmod +x $GCPCSP_HOME/cloud_sql_proxy

echo "Installing default config and init.d script for automatic startup."
cp gcpcsp /etc/init.d/gcpcsp

mkdir -p /etc/gcpcsp/

if [ -f /etc/gcpcsp/gcpcsp.conf ]
then
    cp gcpcsp.conf /etc/gcpcsp/gcpcsp.conf.sample
    echo "Config file /etc/gcpcsp/gcpcsp.conf exists."
    echo "Copying new config as /etc/gcpcsp/gcpcsp.conf.sample"
else
    cp gcpcsp.conf /etc/gcpcsp/gcpcsp.conf
fi

update-rc.d gcpcsp defaults

cat <<EOD
Google Cloud SQL Proxy installed : $GCPCSP_HOME.

!!!! Please update /etc/gcpcsp/gcpcsp.conf before running gcpcsp!

You can control Google Cloud SQL Proxy through the init.d service tool:

START Cloud SQL:	service gcpcsp start
STOP Cloud SQL:		service gcpcsp stop
UNINSTALL Service:	service gcpcsp uninstall

Cloud SQL will log to /var/log/gcpcsp.log

EOD

