#!/usr/bin/env bash
cd /root/codeforfun-microservice
docker-compose pull front-pc
docker-compose rm -s -f front-pc
docker-compose up -d front-pc