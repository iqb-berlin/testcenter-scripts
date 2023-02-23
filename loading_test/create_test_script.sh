#!/bin/bash

source ./loading_test/loading_test.env

if [[ $AUDIT_MODE == 'local' ]]; then

  php loading_test/create_test_script.php > "$WORKING_DIR/script.sh"

elif [[ $AUDIT_MODE == 'docker' ]]; then

  docker exec -w /var/www/backend testcenter-backend /bin/sh -c 'rm -R loading_test | true && mkdir loading_test'
  docker cp -q loading_test/create_test_script.php testcenter-backend:/var/www/backend/loading_test/
  docker cp -q loading_test/loading_test.env testcenter-backend:/var/www/backend/loading_test/
  docker exec -w /var/www/backend testcenter-backend php loading_test/create_test_script.php > "$WORKING_DIR/script.sh"

else

  echo "Unknown mode: $MODE"
  exit 1
fi