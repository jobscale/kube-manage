#!/bin/bash -eu

check() {
  for port in 443 80
  do
    echo -n " PORT $port CHECKING - "
    nc -v -w 1 127.0.0.1 $port < /dev/null || (echo " NG" && exit 1)
    echo " PORT $port SUCCEEDED"
  done
}

loopCheck() {
  for i in {1..99999}
  do
    check
    sleep 60
  done
}

web() {
  for i in {1..99999}
  do
    kubectl port-forward --address 0.0.0.0 svc/web 443:443 80:80
    sleep 30
  done
}

main() {
  web &
  sleep 1
  loopCheck
}

main
