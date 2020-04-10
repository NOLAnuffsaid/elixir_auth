#!/bin/bash

set -e

pg_ctlcluster 11 main start

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
