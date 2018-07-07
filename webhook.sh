#!/usr/bin/env bash
cd /root/codeforfun-microservice
docker-compose -f docker-compose-base.yml pull webhooks
docker-compose -f docker-compose-base.yml rm -s -f webhooks
docker-compose -f docker-compose-base.yml up -d webhooks