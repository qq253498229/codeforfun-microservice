#!/usr/bin/env bash
cd /root/codeforfun-microservice
docker-compose pull mysql
docker-compose rm -s -f mysql
docker-compose up -d mysql