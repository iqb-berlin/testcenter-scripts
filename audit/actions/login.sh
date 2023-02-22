#!/bin/bash

LOGIN_RESULT=$(
curl --location --silent --show-error \
--request PUT "http://localhost/testcenter/backend/session/login" \
--data-raw '{"name":"test-no-pw","password":""}'
)

AUTH_TOKEN=$(echo $LOGIN_RESULT | jq -r ".token")

#curl --location --silent --show-error \
#--request GET "http://localhost/testcenter/backend/session" \
#--header "AuthToken: ""$AUTH_TOKEN"

#TEST_NR=$(
#curl --location --silent --fail --show-error --header  "AuthToken: ""$AUTH_TOKEN" \
#--request PUT "http://localhost/testcenter/backend/test" \
#--data-raw '{"bookletName":"L5.P22.MA01"}'
#)


echo $AUTH_TOKEN;