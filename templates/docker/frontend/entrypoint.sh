#!/bin/bash
set -e

if [[ $NODE_ENV = "production" ]]; then
  yarn install --production=false
  yarn build --dest dist_new
  rm -rf dist
  mv dist_new dist
else
  yarn install
  yarn serve || yarn start
fi

exec "$@"
