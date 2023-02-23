#!/bin/bash

source loading_test.env

[ -d "$WORKING_DIR/merged.log" ] && rm -R "$WORKING_DIR/merged.log"
mkdir loading_test/merged.log

for f in "$WORKING_DIR"/*.log/*/*/stdout; do
    grep "CALL" < "$f" >> "$WORKING_DIR/merged.log/calls.csv"
    grep "FINAL" < "$f" >> "$WORKING_DIR/merged.log/times.csv"
done
