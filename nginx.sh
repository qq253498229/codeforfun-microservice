#!/usr/bin/env bash
cd /root/codeforfun-microservice
docker-compose pull nginx
docker-compose rm -s -f nginx
docker-compose up -d nginx
