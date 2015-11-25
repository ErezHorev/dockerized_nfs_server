#!/bin/bash
set -e
sep_liner=`printf "%0.s-" {1..100}`
echo `docker inspect mynfs | grep -iw ipaddress`

echo $sep_liner
echo -e "\n-- Server's stdout --\n"
docker logs mynfs
echo $sep_liner

echo -e "\n-- Server's processes --\n"
docker top mynfs
echo $sep_liner
