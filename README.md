# docker-multi-php

Multiple versions of php in containers

Users use 1005 uid and gid

Building all

```sh
bin/build.sh
```

Runing
```sh
bin/run.sh [5.6|7|7.2]
```

To add aditional hosts just update
`config/hosts.yml`


Also ssh access for apps , see `config/ssh-users` for setup user access there
```sh
bin/setup_ssh.sh
```

to setup ssh containers with users
