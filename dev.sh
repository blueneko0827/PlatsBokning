#! /bin/bash

docker build -f Postgres.Dockerfile -t postgres_plats .

# Check if a container named "plats-db" exists
if docker ps -a --format '{{.Names}}' | grep -q '^plats-db$'; then
  echo "Container 'plats-db' already exists. Removing it..."
  docker rm -f plats-db
fi

# Run the new container
echo "Starting new container 'plats-db'..."
docker run --name plats-db -p 5432:5432 -d postgres_plats

# For testing
echo "Container 'plats-db' is running."
docker ps -a | grep plats-db