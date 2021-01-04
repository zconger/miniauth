#!/usr/bin/env bash

docker run --tty --volume $(pwd):/hawk --rm \
  -e API_KEY=$SHAWK_API_KEY \
  -e APP_HOST=http://localhost:5000 \
  stackhawk/hawkscan
