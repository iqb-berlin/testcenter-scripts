#!/bin/bash

source .env

DB_CONTAINER_NAME=testcenter-db
TIMEOUT=300
RETURN_HEALTHY=0
RETURN_STARTING=1
RETURN_UNHEALTHY=2
RETURN_UNKNOWN=3
RETURN_ERROR=99

BACKUP_DATE=$(date '+%Y-%m-%d')
BACKUP_DIR=./backup/${BACKUP_DATE}
CUR_DIR=$(basename "$(pwd)")

function get_health_state {
  state=$(docker inspect -f '{{ .State.Health.Status }}' ${DB_CONTAINER_NAME})
  return_code=$?
  if [ ! ${return_code} -eq 0 ]; then
    exit ${RETURN_ERROR}
  fi
  if [[ "${state}" == "healthy" ]]; then
    return ${RETURN_HEALTHY}
  elif [[ "${state}" == "unhealthy" ]]; then
    return ${RETURN_UNHEALTHY}
  elif [[ "${state}" == "starting" ]]; then
    return ${RETURN_STARTING}
  else
    return ${RETURN_UNKNOWN}
  fi
}

function wait_for() {
  printf "Wait for container '%s' to be healthy for max %s seconds ...\n" $DB_CONTAINER_NAME $TIMEOUT
  for i in $(seq ${TIMEOUT}); do
    get_health_state
    state=$?
    if [ ${state} -eq 0 ]; then
      echo "Container is healthy after ${i} seconds."
      return
    fi
    sleep 1
  done

  printf "Timeout exceeded. Health status returned: %s\n" "$(docker inspect -f '{{ .State.Health.Status }}' ${DB_CONTAINER_NAME})"
  exit 1
}

# Create Backup Folder
if [ ! -d "$BACKUP_DIR" ]; then
  mkdir -p "$BACKUP_DIR"
fi

# Shutdown testcenter
echo "Shutdown testcenter ..."
if [ "$TLS_ENABLED" = "on" ] || [ "$TLS_ENABLED" = "yes" ] || [ "$TLS_ENABLED" = "true" ]; then
  docker compose -f docker-compose.yml -f docker-compose.prod.yml -f docker-compose.prod.tls.yml down
else
  docker compose -f docker-compose.yml -f docker-compose.prod.yml down
fi

# Backup DB Volume
echo "Create DB Dump ..."
docker compose -f docker-compose.yml -f docker-compose.prod.yml up -d testcenter-db
echo
wait_for
echo
docker exec $DB_CONTAINER_NAME sh -c 'exec mysqldump --verbose --all-databases -uroot --add-drop-database -p"$MYSQL_ROOT_PASSWORD"' >"${BACKUP_DIR}/all-databases.sql"
echo
docker compose -f docker-compose.yml -f docker-compose.prod.yml down testcenter-db

# echo "Create DB Volume Backup ..."
# vackup export "${CUR_DIR}_dbdata" "${BACKUP_DIR}/dbdata.tar.gz"
echo

# Backup Backend Volume
echo "Create Backend Volume Backup ..."
vackup export "${CUR_DIR}_testcenter_backend_vo_data" "${BACKUP_DIR}/backend_vo_data.tar.gz"
echo
