#!/bin/bash

source ./loading_test/loading_test.env

date >> "$WORKING_DIR/stats.log"
docker stats --no-stream >> "$WORKING_DIR/stats.log"
