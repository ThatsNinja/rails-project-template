#!/bin/bash

# Execute pending migrations
bundle exec rake db:migrate

# Execute assets pre-compile
bundle exec rake assets:precompile

# Start rails server bound to port 80
export SECRET_KEY_BASE=$(rake secret) && \
    bundle exec puma -C config/puma.rb
