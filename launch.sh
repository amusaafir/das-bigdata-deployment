#!/usr/bin/bash

TIMEOUT=00:15:00
MACHINES=4

set -e

RESERVATION_ID=$(./deployer preserve create-reservation -q -t "$TIMEOUT" "$MACHINES")

./deployer preserve wait-for-reservation -t 600 $RESERVATION_ID

./deployer deploy --preserve-id $RESERVATION_ID -s env/das5-hadoop.settings hadoop 2.6.0 log_aggregation=true userlogs_dir=/local/DAS_USERNAME/hadoop/userlogs/

./deployer deploy --preserve-id $RESERVATION_ID zookeeper 3.4.8
