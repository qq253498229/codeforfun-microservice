#!/usr/bin/env bash
cd /root/codeforfun-microservice
docker-compose pull eureka
docker-compose rm -s -f eureka
docker-compose up -d eureka