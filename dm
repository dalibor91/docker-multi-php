#!/bin/bash

APP_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

function _help_msg {
    echo "
    ./dm build  [7.2|7|5.6]  - to build images 
    ./dm run    [7.2|7|5.6]  - to run container 
    ";
}

version=$2

if [ "${version}" = "" ];
then 
    _help_msg
    exit 0;
fi

if [ "$1" = 'build' ];
then 
    echo "Enter container image (If empty 'apache2/php${version}')"
    read container_image
    if [ "$container_image" = "" ]; then container_image="apache2/php${version}"; fi

    docker build -t "$container_image" -f "Dockerfile-${version}" .
elif [ "$1" = 'run' ];
then 
    echo "Enter container image (If empty 'apache2/php${version}')"
    read container_image
    if [ "$container_image" = "" ]; then container_image="apache2/php${version}"; fi

    echo "Enter container name (If empty 'apache2/php${version}')"
    read container_name
    if [ "$container_name" = "" ]; then container_name="apache2/php${version}"; fi

    echo "Enter hostname (If empty 'php${version}')"
    read host_name
    if [ "$host_name" = "" ]; then host_name="php${version}"; fi     

    echo "Enter ports (If empty '8881:80')"
    read ports
    if [ "$ports" = "" ]; then ports="8881:80"; fi     

    echo "Enter network (you can leave it empty)"
    read network

    share=""
    for dir in $(ls "${APP_DIR}/apps/${version}");
    do 
      echo "Share ${APP_DIR}/apps/${version}/$dir ? y/n"
      read yesorno
      if [ "$yesorno" = "y" ]; then share="${share} ${APP_DIR}/apps/${version}/${dir}:/var/www/apps/${dir}"; fi;
    done

    cmd="docker run -it -d --name ${container_name} --hostname ${host_name}"
    for p in ${ports}; do cmd="${cmd} -p ${p}"; done;
    for s in ${share}; do cmd="${cmd} -v ${s}"; done;
    if [ ! "${network}" = "" ]; then cmd="${cmd} --network ${network}"; fi;
    cmd="${cmd} ${container_image}"

    eval "$cmd"
    #echo "$cmd"

    if [ $? -eq 0 ];
    then 
      echo "Started..."
    else 
      echo "Unable to start"
      echo $cmd
    fi
else 
    _help_msg
fi;
