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

function choose_backup_directory() {
  printf "\nBACKUP DIRECTORY SELECTION\n\n"

  printf "Choose backup directory ...\n"
  if [ -d backup ]; then
    declare -a backup_subdir_array
    cd backup && backup_subdir_array=(*) && cd ..

    declare backup_subdir_count=${#backup_subdir_array[*]}
    if [ "$backup_subdir_count" -eq 0 ]; then
      printf "No 'backup' subdirectory found!\n"
      printf "Please create a subdirectory in your '%s' directory and put your backup files " "${CUR_DIR}/backup"
      printf "'%s' and '%s' in it, before you start this shell script again!\n\n" \
        "${DB_DUMP_NAME}" "${BACKEND_VOLUME_BACKUP_NAME}"
      printf 'Data restore script finished with error.\n'

      exit 1
    else
      printf "Backup subdirectory found:\n"
      for ((i = 0; i < backup_subdir_count; i++)); do
        printf -- "  [%d] %q\n" $((i + 1)) "${backup_subdir_array[i]}"
      done
      printf -- "  [%d] Exit restore procedure\n\n" $((backup_subdir_count + 1))

      while read -p "Which one do you want to choose? [1-$((backup_subdir_count + 1))] " -er choice; do
        if [ "$choice" -gt 0 ] && [ "$choice" -le "$backup_subdir_count" ]; then
          BACKUP_DIR=backup/"${backup_subdir_array[$((choice - 1))]}"
          break

        elif [ "$choice" -eq $((backup_subdir_count + 1)) ]; then
          printf "Restore procedure finished without action.\n\n"

          exit 0
        fi
      done
    fi

    printf "Backup directory chosen.\n\n"
  else
    printf "No 'backup' directory found!\n"
    printf "Please create a 'backup' directory and put your backup files "
    printf "'%s' and '%s' in a 'backup' subdirectory, before you start this shell script again!\n\n" \
      "${DB_DUMP_NAME}" "${BACKEND_VOLUME_BACKUP_NAME}"
    printf 'Data restore script finished with error.\n'

    exit 1
  fi

  if [ ! -f "${BACKUP_DIR}"/${DB_DUMP_NAME} ] && [ ! -f backup/"${BACKUP_DIR}"/${BACKEND_VOLUME_BACKUP_NAME} ]; then
    printf "No DB Dump and no Backend Volume Backup file found!\n"
    printf "Please put a '%s' and a '%s' file in your backup subdirectory '%s' and start this shell script again!\n\n" \
      "${DB_DUMP_NAME}" "${BACKEND_VOLUME_BACKUP_NAME}" "${BACKUP_DIR}"
    printf 'Data restore script finished with error.\n'

    exit 1
  fi

  if [ ! -f "${BACKUP_DIR}"/${DB_DUMP_NAME} ]; then
    printf "No DB Dump file found!\n"
    printf "Please put a '%s' file in your backup subdirectory '%s' and start this shell script again!\n\n" \
      "${DB_DUMP_NAME}" "${BACKUP_DIR}"
    printf 'Data restore script finished with error.\n'

    exit 1
  fi

  if [ ! -f "${BACKUP_DIR}"/${BACKEND_VOLUME_BACKUP_NAME} ]; then
    printf "No Backend Volume Backup file found!\n"
    printf "Please put a '%s' file in your backup subdirectory '%s' and start this shell script again!\n\n" \
      "${BACKEND_VOLUME_BACKUP_NAME}" "${BACKUP_DIR}"
    printf 'Data restore script finished with error.\n'

    exit 1
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

function restore_backend_volume() {
  printf "\nBACKEND VOLUME RESTORATION\n\n"

  printf "Restore backend volume backup ...\n"

  vackup import "${BACKUP_DIR}/${BACKEND_VOLUME_BACKUP_NAME}" "${CUR_DIR}_${BACKEND_VOLUME_NAME}"

  printf "\nBackend volume backup restored.\n\n"
}

function get_health_state {
  declare return_code=$?
  declare state
  state=$(docker inspect --format '{{ .State.Health.Status }}' "${DB_CONTAINER_NAME}")

  if [ ! ${return_code} -eq 0 ]; then
    exit "${RETURN_ERROR}"
  fi

  if [[ "${state}" == "healthy" ]]; then
    return "${RETURN_HEALTHY}"
  elif [[ "${state}" == "unhealthy" ]]; then
    return "${RETURN_UNHEALTHY}"
  elif [[ "${state}" == "starting" ]]; then
    return "${RETURN_STARTING}"
  else
    return "${RETURN_UNKNOWN}"
  fi
}

function check_db_container_health() {
  printf "Wait for container '%s' to be healthy for max %s seconds ...\n" "$DB_CONTAINER_NAME" "$TIMEOUT"

  for i in $(seq "${TIMEOUT}"); do
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

restore_db() {
  printf "\nDB RESTORATION\n\n"

  # Load testcenter environment variables
  source .env.prod

  printf "Restore DB Dump ...\n"

  docker compose \
      --env-file .env.prod \
      --file docker-compose.yml \
      --file docker-compose.prod.yml \
    up --detach ${DB_CONTAINER_NAME}
  printf "\n"

  check_db_container_health
  printf "\n"

  # Dropping mysql DB forces a restore failure, so prevent dropping
  sed -i 's/\/\*!40000 DROP DATABASE IF EXISTS `mysql`\*\/;/ /g' "${BACKUP_DIR}/${DB_DUMP_NAME}"

	if docker exec -i ${DB_CONTAINER_NAME} mysql \
	      --verbose \
	      --user=root \
	      --password="${MYSQL_ROOT_PASSWORD}" \
		  <"${BACKUP_DIR}/${DB_DUMP_NAME}"; then

    printf "\n DB Dump restored.\n\n"
  else
    printf 'Data restore script finished with error.\n'

    exit 1
  fi
}

function main() {
  declare start_time
  declare end_time

  start_time=$(date +%s)

  choose_backup_directory

  shutdown_testcenter

  restore_backend_volume

  restore_db

  printf "\n======================================================================================================\n"
  printf "\nTotal backup procedure finished.\n"
  end_time=$(date +%s)

  printf "Elapsed time: %d seconds\n" $((end_time - start_time))
  printf "\n======================================================================================================\n"
}

main
