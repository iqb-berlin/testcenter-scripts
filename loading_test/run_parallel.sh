#!/bin/bash

source ./loading_test/loading_test.env

ulimit -u $RUNS

SEQ=($(seq $RUNS))

parallel --jobs "$RUNS_AT_ONCE" --results "$WORKING_DIR/{}.log" --line-buffer bash "$WORKING_DIR/script.sh" ::: "${SEQ[@]}"
