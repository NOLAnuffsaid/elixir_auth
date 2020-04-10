#!/bin/bash

set -e

mix do clean, compile --force --warning-as-errors

mix format --check-formatted

mix credo --strict

mix test --trace

# mix dialyzer
