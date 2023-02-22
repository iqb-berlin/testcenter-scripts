#!/bin/bash

REMOTE_USER="paf"
REMOTE_URL="loadingtestattacker.iqb.hu-berlin.de"
REMOTE_DIR="~"

# ---

REMOTE_ADDR="$REMOTE_USER@$REMOTE_URL"

echo "### Running Test, attack from $REMOTE_ADDR"

echo "Empty Folder"
[ -d "loading_test" ] && sudo rm -R loading_test
mkdir loading_test

echo "Create Script"
php loading_test_create.php > loading_test/script.sh

echo "Upload script"
scp -r ./loading_test $REMOTE_ADDR:$REMOTE_DIR
scp ./loading_test_parallel.sh $REMOTE_ADDR:$REMOTE_DIR

echo "Run script with audit"
ACTION="ssh $REMOTE_ADDR \"cd $REMOTE_DIR && bash loading_test_parallel.sh\"" \
  bash loading_test_audit_local.sh

echo "Download Results"
scp -r $REMOTE_ADDR:$REMOTE_DIR/loading_test/*.log ./loading_test/

echo "Merge results"
bash loading_test_merge_results.sh
echo "Done"


if [ -f ./loading_test/error.log ]; then
  echo "Errors:"
  cat ./loading_test/error.log
fi