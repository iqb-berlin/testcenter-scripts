#!/bin/bash

source loading_test.env

if [[ ! -v ACTION ]]; then
  echo "ACTION not set"
  exit 1
fi

# start timer
START_TS=$(date +"%s%N")

# watch stats
watch -n"$REPORT_FREQUENCY" bash ./loading_test/mimic_docker_stats.sh &

# Run stuff
eval "$ACTION" >> "$WORKING_DIR/output.log" 2>"$WORKING_DIR/error.log"

# stop recorder
kill %1

# stop timer
END_TS=$(date +"%s%N")
DURATION="$((END_TS-START_TS))"

# write time
echo "Duration total = $DURATION" > "$WORKING_DIR/info.txt"