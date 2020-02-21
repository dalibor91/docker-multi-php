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
    if [ "${ARGS_FILE}" = "" ];
    then
        ARGS_FILE="args-${1}"
    else
        log "ARGS_FILE=${ARGS_FILE}"
    fi
    cat "${APP_DIR}/config/args/${ARGS_FILE}"
}

if [ "$1" = "5.6" ];
then
    run_cmd "docker run `get_args 5.6` `get_shares 5.6` -d php-multi-5.6"
elif [ "$1" = "7.0" ]
then
    run_cmd "docker run `get_args 7.0` `get_shares 7.0` -d php-multi-7.0"
elif [ "$1" = "7.2" ]
then
    run_cmd "docker run `get_args 7.2` `get_shares 7.2` -d php-multi-7.2"
elif [ "$1" = "7.3" ]
then
    run_cmd "docker run `get_args 7.3` `get_shares 7.3` -d php-multi-7.3"
elif [ "$1" = "7.4" ]
then
    run_cmd "docker run `get_args 7.4` `get_shares 7.4` -d php-multi-7.4"
else
    echo "Unknown version"
fi
