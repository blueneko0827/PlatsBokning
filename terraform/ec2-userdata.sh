#!/bin/bash
apt-get update -y
apt-get install -y docker.io git

systemctl start docker
systemctl enable docker

docker pull hectorjacales/plats-bokning:latest

docker run -d -p 3000:3000 \
  -e DB_HOST=${db_host} \
  -e DB_NAME=platsbokning_production \
  -e DB_USERNAME=platsbokning \
  -e DB_PASSWORD='*SametSis1!' \
  -e DB_PORT=5432 \
  hectorjacales/plats-bokning:latest
