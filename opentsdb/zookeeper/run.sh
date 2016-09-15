#!/usr/bin/env bash

wait_for_port() {
    port=$1
    address=${2:-127.0.0.1}
    wait_between_checks=${3:-1}
    checks=${4:-60}

    if [ "${port}" = "" ]; then
        echo "$0 wait_for_port usage: port [address [wait_between_checks checks]]"
        echo "$0 wait_for_port: please supply a value for port (required)"
        exit 1
    else
        echo -n "Trying to connect to ${address}:${port} :"
        for i in $(seq 1 ${checks}); do
          sleep ${wait_between_checks}
          echo -n "."
          $(nc -z ${address} ${port}) && break;

          if [ "$i" = "${checks}" ]; then
            echo "${address}:${port} failed to come up after ${checks} checks. Exiting."
            exit 1;
          fi
        done
    fi
}


ZK_HOME=/app
ZK_PORT=2181
cp -Rf src/main/resources/zookeeper/* "${ZK_HOME}/."
/bin/bash -l ${ZK_HOME}/bin/zkServer.sh start
wait_for_port ${ZK_PORT} 127.0.0.1 10 15
tail -f /dev/null
