#!/bin/bash
set -e

# Run migrations
bin/rails db:migrate

# Start the Rails server
exec bin/rails server -b 0.0.0.0
