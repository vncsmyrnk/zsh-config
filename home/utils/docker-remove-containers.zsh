#!/bin/zsh

docker remove $(docker ps --format '{{.ID}} {{.Names}}' -a | awk '{
  n = split("redis memcached rabbitmq", containers_list)
  for (i = 1; i <= n; i++) {
    containers[containers_list[i]] = 1
  }
  if ($2 in containers) {
    print $1
  }
}')
