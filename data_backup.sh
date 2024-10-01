#!/bin/bash

declare DB_CONTAINER_NAME=testcenter-db
declare DB_DUMP_NAME=all-databases.sql
declare BACKEND_VOLUME_NAME=testcenter_backend_vo_data
declare BACKEND_VOLUME_BACKUP_NAME=backend_vo_data.tar.gz

declare TIMEOUT=300
declare RETURN_HEALTHY=0
declare RETURN_STARTING=1
declare RETURN_UNHEALTHY=2
declare RETURN_UNKNOWN=3
declare RETURN_ERROR=99

declare CUR_DIR
declare BACKUP_DIR

CUR_DIR=$(basename "$(pwd)")
BACKUP_DIR=./backup/$(date '+%Y-%m-%d')

create_backup_dir() {
  if [ ! -d "$BACKUP_DIR" ]; then
    mkdir -p "$BACKUP_DIR"
  fi
}

shutdown_testcenter() {
  printf "\nTESTCENTER SHUTDOWN\n\n"

  printf "Shutdown testcenter ...\n"
  if [ "$TLS_ENABLED" = "on" ] || [ "$TLS_ENABLED" = "yes" ] || [ "$TLS_ENABLED" = "true" ]; then
    docker compose \
        --env-file .env.prod \
        --file docker-compose.yml \
        --file docker-compose.prod.yml \
        --file docker-compose.prod.tls.yml \
      down
  else
    docker compose \
        --env-file .env.prod \
        --file docker-compose.yml \
        --file docker-compose.prod.yml \
      down
  fi
  printf "Shutdown finished.\n\n"
}

function get_health_state {
  declare return_code=$?
  declare state
  state=$(docker inspect --format '{{ .State.Health.Status }}' ${DB_CONTAINER_NAME})

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

function check_db_container_health() {
  printf "Wait for container '%s' to be healthy for max %s seconds ...\n" $DB_CONTAINER_NAME $TIMEOUT

  for i in $(seq ${TIMEOUT}); do
    get_health_state
    declare state=$?

    if [ ${state} -eq 0 ]; then
      printf "Container is healthy after %s seconds.\n" "${i}"
      return
    fi

    sleep 1
  done

  printf "Timeout exceeded. Health status returned: %s\n" \
    "$(docker inspect --format '{{ .State.Health.Status }}' ${DB_CONTAINER_NAME})"
  exit 1
}

backup_db() {
  printf "\nDB DUMP\n\n"
  printf "Starting %s ...\n" ${DB_CONTAINER_NAME}
  docker compose \
      --env-file .env.prod \
      --file docker-compose.yml \
      --file docker-compose.prod.yml \
    up --detach ${DB_CONTAINER_NAME}
  printf "\n"
  check_db_container_health
  printf "%s started.\n\n" ${DB_CONTAINER_NAME}

  printf "Execute 'mysqldump' command ...\n"
	if docker exec $DB_CONTAINER_NAME mysqldump \
	    --verbose \
	    --all-databases \
	    --add-drop-database \
	    --user=root \
		  --password="${MYSQL_ROOT_PASSWORD}" \
		>"${BACKUP_DIR}"/"${DB_DUMP_NAME}"; then

    printf "'mysqldump' finished.\n\n"
  else
    printf 'Data backup script finished with error.\n'

    exit 1
  fi

  printf "Stopping %s ...\n" ${DB_CONTAINER_NAME}
  docker compose \
      --env-file .env.prod \
      --file docker-compose.yml \
      --file docker-compose.prod.yml \
    down ${DB_CONTAINER_NAME}
  printf "%s stopped.\n\n" ${DB_CONTAINER_NAME}
}

backup_backend_volume() {
  printf "\nBACKEND VOLUME BACKUP\n\n"

  printf "Starting backend volume backup ...\n"
  vackup export "${CUR_DIR}_${BACKEND_VOLUME_NAME}" "${BACKUP_DIR}/${BACKEND_VOLUME_BACKUP_NAME}"
  printf "Backend volume backup finished.\n\n"
}

function main() {
  declare start_time
  declare end_time

  start_time=$(date +%s)

  # Load testcenter environment variables
  source .env.prod

  create_backup_dir

  shutdown_testcenter

  backup_db

  backup_backend_volume

  printf "\n======================================================================================================\n"
  printf "\nTotal backup procedure finished.\n"
  end_time=$(date +%s)

  printf "Elapsed time: %d seconds\n" $((end_time - start_time))
  printf "\n======================================================================================================\n"
}

main
