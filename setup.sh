#!/bin/bash

set -e

docker-compose up -d --build database

sleep 6

docker exec -it --privileged database sh -c "psql -U postgres -c \"CREATE USER $ELIXIR_DB_USER WITH CREATEDB LOGIN ENCRYPTED PASSWORD '$DB_PW'\""

echo "Database Setup done!"

APP_ENV=test docker-compose up --build app
