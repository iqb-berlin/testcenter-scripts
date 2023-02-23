#!/bin/bash

source ./loading_test/loading_test.env

if [[ ! -v ACTION ]]; then
  echo "ACTION not set"
  exit 1
fi

# start timer
START_TS=$(date +"%s%N")

# watch stats
if [[ $AUDIT_MODE == 'local' ]]; then
  watch -n"$REPORT_FREQUENCY" bash ./loading_test/mimic_docker_stats.sh &
elif [[ $AUDIT_MODE == 'docker' ]]; then
  docker stats &
else
  echo "Unknown mode: $MODE"
  exit 1
fi

# Run stuff
eval "$ACTION" >> "$WORKING_DIR/output.log" 2>"$WORKING_DIR/error.log"

# stop recorder
kill %1

# stop timer
END_TS=$(date +"%s%N")
DURATION="$((END_TS-START_TS))"

# write time
echo "Duration total = $DURATION" >> "$WORKING_DIR/info.txt"