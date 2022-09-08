#!/bin/bash

set -e

VRRP_GROUP_OR_INSTANCE=$1
VRRP_NAME=$2
STATE=$3
PRIORITY=$4

echo "$VRRP_GROUP_OR_INSTANCE $VRRP_NAME has transitioned to the $STATE state with a priority of $PRIORITY" > /var/run/keepalived_status

# TODO: execute associate_private_ip.sh when $STATE is MASTER