#!/usr/bin/env bash
cd /root/codeforfun-microservice
docker-compose -f docker-compose-base.yml rm -s -f redmine
docker-compose -f docker-compose-base.yml up -d redmine