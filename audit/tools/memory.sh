#!/bin/bash
echo "--- $REPORTFOLDER"
ps aux | awk '/apach[e]/{total+=$4}END{print total}' >> "$REPORTFOLDER/mem.log"
ps aux | awk '/apach[e]/{total+=$3}END{print total}' >> "$REPORTFOLDER/proc.log"