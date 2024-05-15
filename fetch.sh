#!/bin/sh
curl --request PUT 'https://iqb-testcenter.de/api/session/admin' \
--header 'Content-Type: application/json' \
--data '{
    "name": "super",
    "password": "user123"
}'

#curl --silent --location 'https://iqb-testcenter.de/api/workspace/6/responses?groups=sample_group' \
#--header 'AuthToken: a6419ad624d4136.78860941' \
#--header 'Accept: application/json' \
#--data ''