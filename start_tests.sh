#!/bin/bash

set -e

mix do local.hex --force, local.rebar --force

pg_ctlcluster 11 main start

sleep 8

su - postgres && psql -U postgres -c "CREATE USER $ELIXIR_DB_USER WITH CREATEDB LOGIN ENCRYPTED PASSWORD '$DB_PW'"

mix do clean, compile --force --warning-as-errors

mix format --check-formatted

mix credo --strict

MIX_ENV=test mix do ecto.create, ecto.migrate, test --trace

# mix dialyzer
