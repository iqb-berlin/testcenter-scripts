#!/bin/bash

source ./loading_test/loading_test.env

#ulimit -Su $ULIMIT
#ulimit -Sn $ULIMIT
ulimit -n `ulimit -Hn`
ulimit -v unlimited

SEQ=($(seq $RUNS))

parallel -j0 --results "$WORKING_DIR/{}.log" --line-buffer bash "$WORKING_DIR/script.sh" ::: "${SEQ[@]}"

