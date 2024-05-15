#!/bin/bash
make down
docker rm -f $(docker ps -a -q)
docker volume rm $(docker volume ls -q)
sudo find /var/lib/docker/containers/ -type f -name "*.log" -delete
make run