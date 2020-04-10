#!/bin/bash

set -e

mix do clean, compile --force --warning-as-errors

mix format --check-formatted

mix credo --strict

MIX_ENV=test mix do ecto.create, ecto.migrate, test --trace

# mix dialyzer
