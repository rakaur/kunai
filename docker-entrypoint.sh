#!/bin/sh

set -e

# install missing gems
echo "Checking dependencies..."
bundle check || bundle install --jobs 20 --retry 5

# Remove pre-existing pid
#rm -f tmp/pids/server.pid

trap "exit" SIGHUP SIGINT SIGTERM

# run passed commands
echo "Executing: bundle exec ${@}"
bundle exec ${@}
