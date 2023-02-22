#!/bin/bash

NR=100

SEQ=($(seq $NR))

parallel --jobs $NR --results loading_test/{}.log --line-buffer bash loading_test/script.sh ::: "${SEQ[@]}"