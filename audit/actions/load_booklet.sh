#!/bin/bash

curl --location -- silent \
--request GET 'http://localhost/testcenter/backend/workspace/6/file/Booklet/Booklet.xml' \
--header 'AuthToken: '"$AUTH_TOKEN"