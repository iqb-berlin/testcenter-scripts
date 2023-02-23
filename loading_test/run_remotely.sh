#!/bin/bash

set -e

source ./loading_test/loading_test.env

REMOTE_ADDRESS="$REMOTE_USER@$REMOTE_URL"

echo "### Running Test, attack from $REMOTE_ADDRESS"

echo "Create Working Dir: $WORKING_DIR"
bash ./loading_test/create_working_dir.sh

echo "Create Test Script"
bash ./loading_test/create_test_script.sh

echo "Write meta"
bash loading_test/write_meta.sh

echo "Upload script"
ssh "$REMOTE_ADDRESS" "rm -R $REMOTE_DIR/loading_test 2> /dev/null | true && mkdir $REMOTE_DIR/loading_test"
scp -q ./loading_test/run_parallel.sh "$REMOTE_ADDRESS:$REMOTE_DIR/loading_test"
scp -q ./loading_test/create_working_dir.sh "$REMOTE_ADDRESS:$REMOTE_DIR/loading_test"
scp -q ./loading_test/loading_test.env "$REMOTE_ADDRESS:$REMOTE_DIR/loading_test"
scp -q -r "$WORKING_DIR" "$REMOTE_ADDRESS:$REMOTE_DIR"

echo "Run script with audit"
ACTION="ssh $REMOTE_ADDRESS \"cd $REMOTE_DIR && bash loading_test/run_parallel.sh\"" \
  bash loading_test/audit_local.sh

sudo chmod -R 777 "$WORKING_DIR"

echo "Download Results"
scp -q -r "$REMOTE_ADDRESS:$REMOTE_DIR/$WORKING_DIR/*.log" "$WORKING_DIR"

echo "Merge results"
bash loading_test/merge_results.sh
echo "Done"


if [ -f "./$WORKING_DIR/error.log" ]; then
  echo "Errors:"
  cat "./$WORKING_DIR/error.log"
  exit 1
fi