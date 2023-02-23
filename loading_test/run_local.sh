#!/bin/bash

source ./loading_test/loading_test.env

echo "Create Working Dir: $WORKING_DIR"
[ -d "$WORKING_DIR" ] && sudo rm -R "$WORKING_DIR"
mkdir "$WORKING_DIR"

echo "Write meta"
bash loading_test/write_meta.sh

echo "Create Test Script"
php loading_test/create_test_script.php > "$WORKING_DIR/script.sh"

echo "Run script with audit"
ACTION="loading_test/run_parallel.sh" bash loading_test/audit_local.sh

echo "Merge results"
bash loading_test/merge_results.sh

echo "Done"
