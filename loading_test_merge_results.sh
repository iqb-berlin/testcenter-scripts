#!/bin/bash

[ -d "loading_test/merged.log" ] && rm -R loading_test/merged.log
mkdir loading_test/merged.log


for f in loading_test/*.log/*/*/stdout; do
    grep "CALL" < "$f" >> loading_test/merged.log/calls.csv
    grep "FINAL" < "$f" >> loading_test/merged.log/times.csv
done
