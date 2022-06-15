#!/bin/bash

echo -e "\n"

$SPARK_HOME/sbin/stop-all.sh

echo -e "\n"

$HBASE_HOME/bin/stop-hbase.sh

echo -e "\n"

$HADOOP_HOME/sbin/stop-all.sh

