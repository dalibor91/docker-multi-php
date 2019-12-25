#!/bin/bash

. ./bin/_helper.sh

while IFS= read -r line
do
    if [[ "$line" =~ ^\# ]]; then
        continue
    fi
    hostname="`echo $line | awk '{print $1}'`"
    container="php-multi-ssh-${hostname}"
    directory="`echo $line | awk '{print $2}'`"
    userpass="`echo $line | awk '{print $3}'`"
    ports="`echo $line | awk '{print $4}'`"
    network="`echo $line | awk '{print $5}'`"

    directories=""
    for dir in ${directory//;/ };
    do
        directories="-v ${APP_DIR}/apps/${dir}:/srv/${dir} ${directories}"
    done

    container_id="`docker ps -q -f name=${container}`"

    if [ "$container_id" = "" ];
    then
        run_cmd "docker run -d ${directories} -p ${ports} --network ${network} --name ${container} --hostname ${hostname} php-multi-ssh"
    else
        echo "Container for (${container} or ${container_id}) already exists"
    fi

    run_cmd "docker exec ${container} /bin/bash /bin/setup_user.sh ${userpass}"
done < "${APP_DIR}/config/ssh-users"
