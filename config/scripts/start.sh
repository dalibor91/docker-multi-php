#!/bin/bash

service=$(which service)

VERSION=$(cat /opt/version)

cron_location="/opt/config/cron/${VERSION}"
for file in $(ls "$cron_location");
do
    cat "${cron_location}/${file}" > "/etc/cron.d/${file}"
done

$service cron start;

# Build hosts files
python /opt/config/scripts/hosts.py $VERSION

# Copy main configuration
cat /opt/config/apache/apache2.conf > /etc/apache2/apache2.conf

cat "/opt/config/php/${VERSION}/php.ini" > "/etc/php/${VERSION}/apache2/php.ini"

rm /var/www/html/index.html

wget https://assets.dalibor.me/nginx_pages/server.html -O /var/www/html/index.html

if ! [ -d /var/www/html/error ]; then
    mkdir /var/www/html/error
fi

wget https://assets.dalibor.me/nginx_pages/error.html -O /var/www/html/error/index.html
echo -e "<!-- \n> V: ${VERSION}\n> H: `hostname` \n> T: `date` \n-->" >> /var/www/html/index.html

# start apache
/usr/sbin/apache2ctl -DFOREGROUND
