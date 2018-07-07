#!/usr/bin/env bash
cd /root/codeforfun-microservice
docker-compose pull webhooks
docker-compose rm -s -f webhooks
docker-compose up -d webhooks
