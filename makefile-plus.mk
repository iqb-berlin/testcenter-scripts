.PHONY: run

run:
	cd $(TC_BASE_DIR) &&\
	docker compose --file docker/docker-compose.yml --file docker/docker-compose.dev.yml up $(service)

clean:
	make down && \
	docker container stop $(docker ps -a -q) || true && \
	docker container rm -f $(docker ps -a -q) || true && \
	docker volume rm $(docker volume ls -q) || true && \
  docker volume prune --all -f