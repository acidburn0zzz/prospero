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
cd ~/prospero

echo "Initializing database..."
PROSPERO_LOG_LEVEL=warn rake db:create db:migrate db:seed db:test:prepare
if [ $? -eq 0 ]
then
  echo "Database initialized."
fi
