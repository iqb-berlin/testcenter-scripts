#!/bin/bash
source ./loading_test/loading_test.env
[ -d "$WORKING_DIR" ] && rm -R "$WORKING_DIR"
mkdir "$WORKING_DIR"