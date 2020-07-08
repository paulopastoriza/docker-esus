#!/usr/bin/env bash

/etc/init.d/e-SUS-AB-PostgreSQL start
sh /opt/e-SUS/jboss-as-7.2.0.Final/bin/init.d/jboss-as-standalone-lsb.sh start

while sleep 60; do
  ps aux |grep jboss |grep -q -v grep
  PROCESSO=$?
  if [ $PROCESSO -ne 0 ]; then
    echo "Serviço do jboss não esta em execução."
    exit 1
  fi
done
