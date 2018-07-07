#!/usr/bin/env bash
cd /root/codeforfun
docker-compose rm -s -f nginx
docker-compose up -d nginx
