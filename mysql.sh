#!/usr/bin/env bash
cd /root/codeforfun-microservice
docker-compose -f docker-compose-base.yml pull mysql
docker-compose -f docker-compose-base.yml rm -s -f mysql
docker-compose -f docker-compose-base.yml up -d mysql
