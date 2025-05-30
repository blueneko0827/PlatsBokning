#!/bin/bash
apt-get update -y
apt-get install -y docker.io git

systemctl start docker
systemctl enable docker

docker pull hectorjacales/plats-bokning:latest

# Starta containern
container_id=$(docker run -d -p 3000:3000 \
  -e DB_HOST=${db_host} \
  -e DB_NAME=platsbokning_production \
  -e DB_USERNAME=platsbokning \
  -e DB_PASSWORD=g7Hk3qZ9R4 \
  -e DB_PORT=5432 \
  -e SECRET_KEY_BASE=809eb39c93224cb7928572e04dc2eca8960cda0b7ad083e5dbac7d7891065ecbb764d93d63cf83b5c5f2c21de43c248892dc57d6f96cdee94e470af2eb8b5ab1 \
  hectorjacales/plats-bokning:latest)

# Vänta lite så Rails hinner starta
sleep 25

# Skapa databasen
docker exec "$container_id" bin/rails db:create
