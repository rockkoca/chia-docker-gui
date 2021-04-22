#!/usr/bin/env bash

docker build -t rockkoca/chia-docker-gui:latest .
docker push -t rockkoca/chia-docker-gui:latest