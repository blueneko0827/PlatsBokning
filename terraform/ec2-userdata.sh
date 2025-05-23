#!/bin/bash
apt-get update -y
apt-get install -y docker.io git

systemctl start docker
systemctl enable docker

docker pull your_dockerhub_user/rails_app:latest

docker run -d -p 3000:3000 \
  -e DB_HOST=${db_host} \
  -e DB_NAME=${db_name} \
  -e DB_USERNAME=${db_username} \
  -e DB_PASSWORD=${db_password} \
  -e DB_PORT=5432 \
  your_dockerhub_user/rails_app:latest
