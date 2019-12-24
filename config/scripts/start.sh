#!/bin/bash

service=$(which service)

# This script is used to start everything
$service ssh status > /dev/null 2>&1
if [ $? -eq 0 ];
then
    $service ssh start;
    echo "SSH service started..."
fi

$service cron status > /dev/null 2>&1
if [ $? -eq 0 ];
then
    $service cron start;
    echo "Cron started..."
fi

# Build hosts files
python /opt/config/scripts/hosts.py $(cat /opt/version)

# Copy main configuration
cat /opt/config/apache/apache2.conf > /etc/apache2/apache2.conf

# start apache
/usr/sbin/apache2ctl -DFOREGROUND
