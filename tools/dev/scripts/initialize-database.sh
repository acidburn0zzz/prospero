#!/usr/bin/env bash

# Prospero
#
# You should have received a copy of the license along with this program.
#
# Licensed under
# - GNU Affero General Public License V3
# - CeCILL Affero compliant

# Initialize database schema
echo "Initializing database schema..."
source ~/.rvm/scripts/rvm
cd /srv/prospero

echo "Initializing development database..."
PROSPERO_LOG_LEVEL=warn rake db:migrate
echo "Initializing test database..."
PROSPERO_LOG_LEVEL=warn RAILS_ENV=test rake db:migrate
if [ $? -eq 0 ]
then
  echo "Database initialized."
fi
