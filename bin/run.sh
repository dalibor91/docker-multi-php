#!/bin/bash

. ./bin/_helper.sh

function get_shares() {
    local share="-v ${APP_DIR}/config:/opt/config"
    for dir in $(ls "${APP_DIR}/apps/${1}");
    do
      share="${share} -v ${APP_DIR}/apps/${1}/${dir}:/var/www/apps/${dir}";
    done

    echo $share
}

function get_args() {
    cat "${APP_DIR}/config/args/args-${1}"
}

if [ "$1" = "5.6" ];
then
    run_cmd "docker run `get_args 5.6` `get_shares 5.6` -d php-multi-5.6"
elif [ "$1" = "7" ]
then
    run_cmd "docker run `get_args 7` `get_shares 7` -d php-multi-7"
elif [ "$1" = "7.2" ]
then
    run_cmd "docker run `get_args 7.2` `get_shares 7.2` -d php-multi-7.2"
else
    echo "Unknown version"
fi
