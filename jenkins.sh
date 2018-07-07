#!/usr/bin/env bash
cd /root/codeforfun
docker-compose -f docker-compose-base.yml build jenkins
docker-compose -f docker-compose-base.yml rm -s -f jenkins
docker-compose -f docker-compose-base.yml up -d jenkins