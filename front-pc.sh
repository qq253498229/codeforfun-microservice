#!/usr/bin/env bash
cd /root/codeforfun-microservice
docker-compose -f docker-compose-base.yml pull front-pc
docker-compose -f docker-compose-base.yml rm -s -f front-pc
docker-compose -f docker-compose-base.yml up -d front-pc