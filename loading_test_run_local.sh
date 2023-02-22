#!/bin/bash

echo "Create Script"
php loading_test_create.php
echo "Run script with audit"
ACTION="loading_test_run.sh" bash loading_test_audit_local.sh
echo "Merge results"
bash loading_test_merge_results.sh
echo "Done"
