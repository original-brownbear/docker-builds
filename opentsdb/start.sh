#!/usr/bin/env bash
rm -rf ./target
cp -r ./src ./target 
cp -r ./ssh ./target/namenode
cp -r ./ssh ./target/datanode
cp -r ./ssh ./target/hbase
cd target
docker-compose up --build
