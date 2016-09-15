#!/usr/bin/env bash
export JRUBY_OPTS=''
export JAVA_HOME=''
export COMPRESSION=NONE
OTSB_PORT=4242
ZK_PORT=2181
cd /app
src/create_table.sh
tsdtmp=${TMPDIR-/tmp}/tsd
mkdir -p "$tsdtmp"
cp -f /logback.xml src/logback.xml
./build/tsdb tsd --port=${OTSB_PORT} \
    --config=opentsdb.conf \
    --staticroot=build/staticroot \
    --cachedir="$tsdtmp" \
    --zkquorum=zookeeper:${ZK_PORT}
