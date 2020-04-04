#!/bin/bash

set -e

mix do local.hex --force, \
       local.rebar --force, \
       deps.get, \
       deps.compile, \
       ecto.create, \
       ecto.migrate

if [ "$MIX_ENV" = "test" ]; then
  echo "Running test environment..."
  mix test

  return 0
fi

echo "Running prod environment..."

sleep 5
