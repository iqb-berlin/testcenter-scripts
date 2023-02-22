#!/bin/bash
loginResponse=$(
  curl -sS 'http://localhost/testcenter/backend/session/login' -X PUT \
    --data-raw '{"name":"test-no-pw","password":""}'
)
loginToken=${loginResponse:10:24}
echo "LoginToken: $loginToken"

testId=$(
  curl -sS 'http://localhost/testcenter/backend/test' -X PUT \
    -H "AuthToken: $loginToken" \
    --data-raw '{"bookletName":"BOOKLET.SAMPLE-1"}'
)
echo "TestId: $testId"
