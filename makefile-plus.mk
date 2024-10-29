.PHONY: run

run:
	cd $(TC_BASE_DIR) &&\
	docker compose --file docker/docker-compose.yml --file docker/docker-compose.dev.yml up $(service)
