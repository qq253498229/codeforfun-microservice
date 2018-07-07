#!/usr/bin/env bash
cd /root/codeforfun-microservice
docker-compose -f docker-compose-base.yml pull jenkins
docker-compose -f docker-compose-base.yml rm -s -f jenkins
docker-compose -f docker-compose-base.yml up -d jenkins
