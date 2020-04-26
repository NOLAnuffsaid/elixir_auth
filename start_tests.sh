#!/bin/bash

set -e

pg_ctlcluster 11 main start

echo $ELIXIR_DB_USER
echo $DB_PW

MIX_ENV=test mix do \
  local.hex --force, \
  local.rebar --force, \
  clean, \
  compile --force --warning-as-errors, \
  format --check-formatted, \
  credo --strict, \
  ecto.create, \
  ecto.migrate, \
  test --trace

# mix dialyzer
