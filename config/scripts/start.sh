#!/bin/bash

service=$(which service)

cron_location="/opt/config/cron/`cat /opt/version`"
for file in $(ls "$cron_location");
do
    cat "${cron_location}/${file}" > "/etc/cron.d/${file}"
done

$service cron start;

# Build hosts files
python /opt/config/scripts/hosts.py $(cat /opt/version)

# Copy main configuration
cat /opt/config/apache/apache2.conf > /etc/apache2/apache2.conf

# start apache
/usr/sbin/apache2ctl -DFOREGROUND
