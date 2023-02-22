#!/bin/bash

LOGIN_RESULT=$(
curl --location --silent --show-error \
--request PUT "http://localhost/testcenter/backend/session/login" \
--data-raw '{"name":"test","password":"user123"}'
)

LOGIN_TOKEN=$(echo $LOGIN_RESULT | jq -r ".token")

PERSON_RESULT=$(
curl --location --silent --show-error \
--request PUT "http://localhost/testcenter/backend/session/person" \
--header "AuthToken: ""$LOGIN_TOKEN" \
--data-raw '{"code":"xxx"}'
)

PERSON_TOKEN=$(echo $PERSON_RESULT | jq -r ".token")

echo "$LOGIN_TOKEN || $PERSON_TOKEN";