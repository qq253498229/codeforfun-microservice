#!/usr/bin/env bash
cd /root/codeforfun-microservice
docker-compose rm -s -f redmine
docker-compose up -d redmine