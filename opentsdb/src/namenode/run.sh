#!/usr/bin/env bash

set -e

echo "datanode" > /app/etc/hadoop/slaves
rm "/app/etc/hadoop/core-site.xml"
cat <<"EOF" > "/app/etc/hadoop/core-site.xml"
<configuration>
    <property>
        <name>fs.defaultFS</name>
        <value>hdfs://namenode:9000</value>
    </property>
    <property>
        <name>hadoop.tmp.dir</name>
        <value>${java.io.tmpdir}/hadoop</value>
    </property>
</configuration>
EOF

service ssh start
cd /app
/bin/bash -l bin/hdfs namenode -format -force
/bin/bash -l sbin/start-dfs.sh
/bin/bash -l bin/hdfs dfs -mkdir -p /raw-data
/bin/bash -l sbin/start-yarn.sh

tail -f /dev/null
