#!/bin/bash
set -e

ipv4_regex="([0-9]{1,3}[\.]){3}[0-9]{1,3}"

docker run -d --name mynfs --privileged erezhorev/dockerized_nfs_server $@

nfsip=`docker inspect mynfs | grep -iw ipaddress | grep -Eo $ipv4_regex`

# Source the script to populate MYNFSIP env var
export MYNFSIP=$nfsip

echo "Nfs Server IP: "$MYNFSIP
