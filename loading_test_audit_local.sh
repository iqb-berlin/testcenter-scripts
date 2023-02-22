#!/bin/bash

if [[ ! -v ACTION ]]; then
  echo "ACTION not set"
  exit 1
fi

REPORTFOLDER="./loading_test"

echo "t";
# watch stats
watch -n0.5 REPORTFOLDER=$REPORTFOLDER bash ./audit/tools/mimic_docker_stats.sh &

echo "s";
# Run stuff
eval "$ACTION" >> "$REPORTFOLDER/output.log" 2>"$REPORTFOLDER/error.log"

# stop recorder
echo "STOP recorder!"
kill %1

sudo chmod -R 777 "$REPORTFOLDER"