#!/usr/bin/env bash
cd /root/codeforfun/codeforfun-microservice
docker-compose pull webhooks
docker-compose rm -s -f webhooks
docker-compose up -d webhooks
