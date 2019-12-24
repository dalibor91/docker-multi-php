#!/bin/bash

APP_DIR="$( cd $( dirname "$( dirname "${BASH_SOURCE[0]}" )" ) && pwd )"

function log() {
    echo "[`date`] [`whoami`] $@" >> "${APP_DIR}/record.log"
}

function run_cmd() {
    log "$@"
    eval "$@"
}
