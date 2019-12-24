#!/bin/bash

service=$(which service)

# This script is used to start everything
$service ssh status
if [ $? -eq 0 ];
then
    $service ssh start;
    echo "SSH service started..."
fi

$service cron status
if [ $? -eq 0 ];
then
    $service cron start;
    echo "Cron started..."
fi

python /opt/config/scripts/hosts.py $(cat /opt/version)

/usr/sbin/apache2ctl -DFOREGROUND
