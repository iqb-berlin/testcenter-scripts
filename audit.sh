#!/bin/bash
# call me like ACTION=get_files AUTH_TOKEN=a63a30f1ca53b08.05509630 bash audit.sh

if [[ ! -v ACTION ]]; then
  echo "ACTION not set"
  exit 1
fi

REPORTFOLDER="./audit_report-$ACTION"


# https://www.baeldung.com/linux/auditd-monitor-file-access

[ -d "$REPORTFOLDER" ] && rm -R "$REPORTFOLDER"
mkdir "$REPORTFOLDER"
touch "$REPORTFOLDER/responses.log"
touch "$REPORTFOLDER/error.log"
touch "$REPORTFOLDER/duration.log"

augenrules --load > /dev/null
auditd
service apache2 restart

# free -s 0.01 > $REPORTFOLDER/mem.log &
# watch -n1 pidstat -hurd -C apache2
watch -n0.1 REPORTFOLDER=$REPORTFOLDER bash ./audit/tools/memory.sh &

START=$(date +"%H:%M:%S")
START_TS=$(date +"%s%N")

# Run stuff
{
 bash "audit/actions/$ACTION.sh"
} >> "$REPORTFOLDER/responses.log" 2>"$REPORTFOLDER/error.log"

# stop timer
END_TS=$(date +"%s%N")
DURATION="$((END_TS-START_TS))"

# stop recorder
kill %1

# show measurements
FSA=$(aureport -f -i --start "$START" | grep /usr/sbin/apache2)

echo ""
echo "--------------------------------------------------------------------------------------------------------"
echo "Memory"
cat "$REPORTFOLDER/mem.log"

echo ""
echo "--------------------------------------------------------------------------------------------------------"
echo "Processor"
cat "$REPORTFOLDER/proc.log"

echo ""
echo "--------------------------------------------------------------------------------------------------------"
echo "Filesystem Calls:"
echo "$FSA"

echo ""
echo "--------------------------------------------------------------------------------------------------------"
echo "Duration (in ns): "
echo $DURATION

echo ""
echo "--------------------------------------------------------------------------------------------------------"
echo "Filesystem Calls Count:"
echo "$FSA" | awk 'NF' | wc -l

echo ""
echo "--------------------------------------------------------------------------------------------------------"
echo "Errors:"
cat "$REPORTFOLDER/error.log"

echo ""
echo "--------------------------------------------------------------------------------------------------------"
echo ""

# log
echo "$FSA" > "$REPORTFOLDER/fsa.log"
echo "$DURATION" > "$REPORTFOLDER/duration.log"


chmod -R 777 "$REPORTFOLDER"