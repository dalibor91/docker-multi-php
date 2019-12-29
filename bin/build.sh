#!/bin/bash

. ./bin/_helper.sh

run_cmd 'docker build -t "php-multi-5.6" -f "Dockerfile-5.6" .'
run_cmd 'docker build -t "php-multi-7.0" -f "Dockerfile-7.0" .'
run_cmd 'docker build -t "php-multi-7.2" -f "Dockerfile-7.2" .'
run_cmd 'docker build -t "php-multi-ssh" -f "Dockerfile-ssh" .'
