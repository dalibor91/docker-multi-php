#!/bin/bash

APP_DIR="$( cd $( dirname "$( dirname "${BASH_SOURCE[0]}" )" ) && pwd )"

function log() {
    echo "[`date`] [`whoami`] $@" >> "${APP_DIR}/record.log"
}

function run_cmd() {
    local cmd_running=$@
    log "${cmd_running}"
    eval "${cmd_running}"
    if ! [ $? -eq 0 ];
    then 
        echo "Command failed: '${cmd_running}'"
    fi
}
