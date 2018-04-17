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
    docker run -it -d --name apache_php56 \
      --hostname php56 \
      -p "8882:80" \
      -v "${APP_DIR}/apps/5.6:/var/www/apps" \
      apache2/php5.6
  else 
    echo "Please specify version"
  fi
else 
  echo "
  ./dm build  [7|5.6]  - to build images 
  ./dm run    [7|5.6]  - to run container 
  ";
fi;
