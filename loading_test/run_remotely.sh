#!/bin/bash

source loading_test.env

REMOTE_ADDRESS="$REMOTE_USER@$REMOTE_URL"

echo "### Running Test, attack from $REMOTE_ADDRESS"

echo "Create Working Dir: $WORKING_DIR"
[ -d "$WORKING_DIR" ] && sudo rm -R "$WORKING_DIR"
mkdir "$WORKING_DIR"

echo "Create Test Script"
php loading_test/create_test_script.php > "$WORKING_DIR/script.sh"

echo "Create Working Dir Remotely"
ssh "$REMOTE_ADDRESS" "cd $REMOTE_DIR && rm -R loading_test* && mkdir loading_test"

echo "Upload script"
scp -R ./loading_test/"$WORKING_DIR" "$REMOTE_ADDRESS:$REMOTE_DIR"
scp ./loading_test/parallel.sh "$REMOTE_ADDRESS:$REMOTE_DIR"
scp ./loading_test/loading_test.env "$REMOTE_ADDRESS:$REMOTE_DIR"

echo "Run script with audit"
ACTION="ssh $REMOTE_ADDRESS \"cd $REMOTE_DIR/loading_test && bash parallel.sh\"" \
  bash loading_test/audit_local.sh

sudo chmod -R 777 "$WORKING_DIR"

echo "Download Results"
scp -r "$REMOTE_ADDRESS:$REMOTE_DIR/loading_test/$WORKING_DIR/*.log" "$WORKING_DIR"

echo "Merge results"
bash loading_test/merge_results.sh
echo "Done"


if [ -f "./$WORKING_DIR/error.log" ]; then
  echo "Errors:"
  cat "./$WORKING_DIR/error.log"
  exit 1
fi