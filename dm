#!/bin/bash

APP_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

if [ "$1" = 'build' ];
then 
  if [ "$2" = '7' ];
  then 
    docker build -t apache2/php7 -f Dockerfile-7 .
  elif [ "$2" = '5.6' ];
  then
    docker build -t apache2/php5.6 -f Dockerfile-5.6 .
  else 
    echo "Please specify version"
  fi
elif [ "$1" = 'run' ];
then 
  if [ "$2" = '7' ];
  then 
    docker run -it -d --name apache_php7 \
      --hostname php7 \
      -p "8881:80" \
      -v "${APP_DIR}/apps/7:/var/www/apps" \
      apache2/php7
  elif [ "$2" = '5.6' ];
  then
      echo "Enter container name (If empty 'apache2/php5.6')"
      read container_name
      if [ "$container_name" = "" ]; then container_name="apache2/php5.6"; fi
   
      echo "Enter hostname (If empty 'php56')"
      read host_name
      if [ "$host_name" = "" ]; then host_name="php56"; fi     
      
      echo "Enter ports (If empty '8881:80')"
      read ports
      if [ "$ports" = "" ]; then ports="8881:80"; fi     
     
      echo "Enter network (you can leave it empty)"
      read network

      share=""
      for dir in $(ls "${APP_DIR}/apps/5.6");
      do 
        echo "Share ${APP_DIR}/apps/5.6/$dir ? y/n"
        read yesorno
        if [ "$yesorno" = "y" ]; then share="${share} ${APP_DIR}/apps/5.6/${dir}:/var/www/apps/${dir}"; fi;
      done
      
      cmd="docker run -it -d --name ${container_name} --hostname ${host_name}"
      for p in "${ports}"; do cmd="${cmd} -p ${p}"; done;
      for s in "${share}"; do cmd="${cmd} -v ${s}"; done;
      if [ ! "${network}" = "" ]; then cmd="${cmd} --network ${network}"; fi;
      cmd="${cmd} apache2/php5.6"

      eval "$cmd"
      #echo "$cmd"

      if [ $? -eq 0 ];
      then 
        echo "Started..."
      else 
        echo "Unable to start"
        echo $cmd
      fi
      #docker run -it -d --name apache_php56 \
      #--hostname php56 \
      #-p "8882:80" \
      #-v "${APP_DIR}/apps/5.6:/var/www/apps" \
      #$container_name
  else 
    echo "Please specify version"
  fi
else 
  echo "
  ./dm build  [7|5.6]  - to build images 
  ./dm run    [7|5.6]  - to run container 
  ";
fi;
