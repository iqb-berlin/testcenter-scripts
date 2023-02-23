#!/bin/bash

source loading_test/loading_test.env

if [[ $MODE == 'local' ]]; then
  bash loading_test/run_local.sh
elif [[ $MODE == 'remote' ]]; then
  bash loading_test/run_remotely.sh
else
  echo "Unknown mode: $MODE"
  exit 1
fi