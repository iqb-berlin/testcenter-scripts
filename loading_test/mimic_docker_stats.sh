#!/bin/bash

source loading_test.env

MEM=$(ps aux | awk '/apach[e]/{total+=$4}END{print total}')
PROC=$(ps aux | awk '/apach[e]/{total+=$3}END{print total}')
PIDS=$(ps aux | awk '/apach[e]/{total+=1}END{print total}')
sudo echo "Local          Apache    $PROC     -- / --             $MEM      --/--     --/--       $PIDS" >> "$WORKING_DIR/stats.log"