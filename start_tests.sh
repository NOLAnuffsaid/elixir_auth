#!/bin/bash

set -e

pg_ctlcluster 11 main start

sleep 8

su - postgres && psql -U postgres -c "CREATE USER $ELIXIR_DB_USER WITH CREATEDB LOGIN ENCRYPTED PASSWORD '$DB_PW'"

mix do \
  local.hex --force, \
  local.rebar --force, \
  clean, \
  compile --force --warning-as-errors, \
  format --check-formatted, \
  credo --strict, \
  MIX_ENV=test ecto.create, \
  MIX_ENV=test ecto.migrate, \
  test --trace

# mix dialyzer
