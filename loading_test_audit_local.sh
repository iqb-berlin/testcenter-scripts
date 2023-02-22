#!/bin/bash

if [[ ! -v ACTION ]]; then
  echo "ACTION not set"
  exit 1
fi

REPORTFOLDER="./loading_test"


# https://www.baeldung.com/linux/auditd-monitor-file-access

watch -n0.1 REPORTFOLDER=$REPORTFOLDER bash ./audit/tools/memory.sh &

START=$(date +"%H:%M:%S")
START_TS=$(date +"%s%N")

# Run stuff
{
 bash "$ACTION"
} >> "$REPORTFOLDER/output.log" 2>"$REPORTFOLDER/error.log"

# stop timer
END_TS=$(date +"%s%N")
DURATION="$((END_TS-START_TS))"

# stop recorder
kill %1


echo ""
echo "--------------------------------------------------------------------------------------------------------"
echo "Memory"
cat "$REPORTFOLDER/mem.log"

echo ""
echo "--------------------------------------------------------------------------------------------------------"
echo "Processor"
cat "$REPORTFOLDER/proc.log"


chmod -R 777 "$REPORTFOLDER"