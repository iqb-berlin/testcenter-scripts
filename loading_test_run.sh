#!/bin/bash


SEQ=($(seq 2))

rm -R loading_test/*.log || true

parallel --results loading_test/{}.log --line-buffer bash loading_test/script.sh ::: "${SEQ[@]}"
