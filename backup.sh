#!/bin/bash
set -e

if [ ! -d backup ]; then
  mkdir backup
fi

DATE="$(date)"
NETWORKNAME="$(basename $(pwd))"

mkdir "backup/$DATE"
tar -cvzf "backup/$DATE/db.tar" "/var/lib/docker/volumes/${NETWORKNAME}_dbdata"
tar -cvzf  "backup/$DATE/data.tar" "/var/lib/docker/volumes/${NETWORKNAME}_testcenter_backend_vo_data"