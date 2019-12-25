#!/bin/bash

# called inside of container

export DEBIAN_FRONTEND=noninteractive

user=$(echo $1 | awk -F: '{print $1}')
pass=$(echo $1 | awk -F: '{print $2}')
uidgid=$(echo $1 | awk -F: '{print $3}')

echo "username: ${user} password: ${pass}"

id $user
if ! [ $? -eq 0 ];
then
    adduser --quiet --shell /bin/bash --home "/home/${user}" --uid $uidgid --disabled-password --gecos "" $user
    groupmod -g $uidgid $user
    ln -s "/srv" "/home/${user}/public"
fi

echo "${user}:${pass}" | chpasswd
