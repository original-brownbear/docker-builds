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

HBASE_HOME=/app

rm "${HBASE_HOME}/conf/hbase-site.xml"
cat <<EOF > "${HBASE_HOME}/conf/hbase-site.xml"
<configuration>
    <property>
        <name>hbase.cluster.distributed</name>
        <value>true</value>
    </property>
    <property>
        <name>hbase.rootdir</name>
        <value>hdfs://namenode:8020/hbase</value>
    </property>
    <property>
        <name>hbase.rootdir</name>
        <value>file://${HBASE_HOME}</value>
    </property>
    <property>
      <name>hbase.zookeeper.property.clientPort</name>
      <value>2181</value>
    </property>
    <property>
      <name>hbase.zookeeper.quorum</name>
      <value>zookeeper</value>
    </property>
</configuration>
EOF

cat <<EOF > "${HBASE_HOME}/conf/hbase-env.sh"
export JAVA_HOME=${JAVA_HOME}
export HBASE_MANAGES_ZK=false
EOF


ZK_HOME=/app
ZK_PORT=2181
/bin/bash -l ${ZK_HOME}/bin/zkServer.sh start
wait_for_port ${ZK_PORT} 127.0.0.1 10 15
tail -f /dev/null
