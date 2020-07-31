#!/bin/bash -eu

check() {
  for port in 443 3306 8080 8081
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
    sleep 300
  done
}

wetty() {
  for i in {1..99999}
  do
    kubectl port-forward --address 0.0.0.0 svc/wetty 443:443
    sleep 120
  done
}

mysql() {
  for i in {1..99999}
  do
    kubectl port-forward --address 0.0.0.0 svc/mysql 3306:3306
    sleep 120
  done
}

swaggerEditor() {
  for i in {1..99999}
  do
    kubectl port-forward --address 0.0.0.0 svc/swagger-editor 8080:80
    sleep 120
  done
}

swaggerUi() {
  for i in {1..99999}
  do
    kubectl port-forward --address 0.0.0.0 svc/swagger-ui 8081:81
    sleep 120
  done
}

main() {
  swaggerUi &
  sleep 1
  swaggerEditor &
  sleep 1
  mysql &
  sleep 1
  wetty &
  sleep 3
  loopCheck
}

main
