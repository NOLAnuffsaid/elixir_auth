#!/bin/bash

set -e

MIX_ENV=test

mix do deps.get, deps.get, dialyzer --plt

mix do clean, compile --force --warning-as-errors

mix format --check-formatted

mix credo --strict

mix test --trace

mix dialyzer
