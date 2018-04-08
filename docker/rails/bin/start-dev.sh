#!/bin/bash

# Check for presence of firstrun file, execute database creation and touch
# firstrun if not found
if [ ! -f ./firstrun ]; then
  bundle exec rake db:create db:schema:load db:seed
  touch ./firstrun
fi

# Clean up server.pid if left over from previous container run
if [ -f ./tmp/pids/server.pid ]; then
  rm ./tmp/pids/server.pid
fi

# Execute pending migrations
bundle exec rake db:migrate

# Execute assets pre-compile
bundle exec rake assets:precompile

# Start rails server bound to port 80
export SECRET_KEY_BASE=$(rake secret) && \
    bundle exec rails s -b 0.0.0.0
