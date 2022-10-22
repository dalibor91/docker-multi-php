# docker-multi-php

Multiple versions of php in containers

Versions supported 
- 5.6
- 7
- 7.2
- 7.3
- 7.4
- 8.1

Users use 1005 uid and gid

Building all

```sh
bin/build.sh [optional:version]
```

Runing
```sh
bin/run.sh [version]

ARGS_FILE=custom-file bin/run 5.6
```

To add aditional hosts just update
`config/hosts.yml`


Also ssh access for apps , see `config/ssh-users` for setup user access there
```sh
bin/setup_ssh.sh
```

to setup ssh containers with users

Cron files are in `config/cron`

## Docker-compose 
To test with docker-compose run 
```bash 
VERSION=8.1 docker-compose run --service-ports app
```

Then inside container 
```bash
chown apache-user /var/www/apps/test

su - apache-user

cd /var/www/apps/test

composer create-project --prefer-dist laravel/lumen .
```
