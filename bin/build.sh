#!/bin/bash

build_version=$1

. ./bin/_helper.sh

if [ "${build_version}" = "" ];
then
    run_cmd 'docker build -t "php-multi-5.6" -f "Dockerfile-5.6" .'
    run_cmd 'docker build -t "php-multi-7.0" -f "Dockerfile-7.0" .'
    run_cmd 'docker build -t "php-multi-7.2" -f "Dockerfile-7.2" .'
    run_cmd 'docker build -t "php-multi-7.3" -f "Dockerfile-7.3" .'
    run_cmd 'docker build -t "php-multi-7.4" -f "Dockerfile-7.4" .'
    run_cmd 'docker build -t "php-multi-8.1" -f "Dockerfile-8.1" .'
    run_cmd 'docker build -t "php-multi-8.2" -f "Dockerfile-8.2" .'
    run_cmd 'docker build -t "php-multi-ssh" -f "Dockerfile-ssh" .'
else 
    run_cmd "docker build -t "php-multi-ssh" -f "Dockerfile-${build_version}" ."
fi
