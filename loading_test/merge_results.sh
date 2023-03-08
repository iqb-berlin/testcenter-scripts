#!/bin/bash

# source ./loading_test/loading_test.env

for d in "$WORKING_DIR"/*.log/*/*; do

    grep "CALL" < "$d/stdout" >> "$WORKING_DIR/calls.csv"
    grep "FINAL" < "$d/stdout" >> "$WORKING_DIR/times.csv"

    if [ -s "$d/stderr" ]; then

        echo "" >> "$WORKING_DIR/error.log"
        cat "$d/seq" >> "$WORKING_DIR/error.log"
        echo ")" >> "$WORKING_DIR/error.log"
        cat "$d/stderr" >> "$WORKING_DIR/error.log"
    fi
done

for d in "$WORKING_DIR"/*.log/; do
    rm -r $d
done

