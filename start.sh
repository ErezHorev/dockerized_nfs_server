#!/bin/bash
set -e

docker run -d --name mynfs --privileged --env-file=.envNFS docker.io/erezhorev/dockerized_nfs_server $@

# Source the script to populate MYNFSIP env var
export MYNFSIP=$(docker inspect -f '{{.NetworkSettings.IPAddress}}' mynfs)

echo "Nfs Server IP: "$MYNFSIP
