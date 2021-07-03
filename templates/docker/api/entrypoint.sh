#!/bin/bash
set -e

sudo cron

bundle config set path .bundle

if [[ $RAILS_ENV = "production" ]] || [[ $RAILS_ENV = "staging" ]]; then
  bundle config set without 'development test'
fi

bundle check || bundle install

rm -f tmp/pids/server.pid

bundle exec rails s -p 3000 -b '0.0.0.0'

exec "$@"
