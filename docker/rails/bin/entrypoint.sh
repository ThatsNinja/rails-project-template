#!/usr/bin/env bash

if [ "$CIRCLECI" = "true" ]
then
  echo "Applying Circle-specific Container hacks..."
  gem install rubygems-update
  update_rubygems --no-document
fi


if `rake db:migrate:status | awk '{ print $1 }' | grep 'down'`
then
  echo "Pending migrations found....running now"
  rake db:migrate
  echo "Refreshing search indexes"
  rake pharos:refresh_search_indexes
fi

exec "$@"
