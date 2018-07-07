#!/usr/bin/env bash
cd /root/codeforfun
docker-compose rm -s -f jenkins
docker-compose up -d jenkins
