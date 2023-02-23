#!/bin/bash

echo "Create Script"
php loading_test/create_test_script.php

echo "Run script with audit"
ACTION="loading_test/run_parallel.sh" bash loading_test/audit_local.sh

echo "Merge results"
bash loading_test/merge_results.sh

echo "Done"
