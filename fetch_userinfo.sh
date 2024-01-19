#!/bin/bash

source .env

fetch() {
  (
     docker exec -it -e MYSQL_PWD="$MYSQL_PASSWORD" testcenter-db \
      mysql -u "$MYSQL_USER"  -D "$MYSQL_DATABASE" -e "$2" -B \
  ) \
    | tr '\t' ',' \
    > "$HOSTNAME-$1.csv"
}

fetch \
  "workspaces" \
  "select
    workspaces.id as workspace_id,
    workspaces.name as workspace_name,
    max(files.modification_ts) as last_file_modification,
    max(tests.timestamp_server) as last_testee_active
  from workspaces
    left join files on workspaces.id = files.workspace_id
    left join login_sessions on login_sessions.workspace_id = workspaces.id
    left join person_sessions on person_sessions.login_sessions_id = login_sessions.id
    left join tests on person_sessions.id = tests.person_id
  group by workspaces.id, workspaces.name
  order by workspaces.name;
  "

fetch \
  "workspace_users" \
  "select
     workspace_id,
     workspaces.name as workspace_name,
     user_id,
     users.name as user_name,
     role
   from workspace_users
     left join users on workspace_users.user_id = users.id
     left join workspaces on workspace_id = workspaces.id;"
