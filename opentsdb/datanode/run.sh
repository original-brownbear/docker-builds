#!/usr/bin/env bash
set -e
service ssh start

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

tail -f /dev/null
