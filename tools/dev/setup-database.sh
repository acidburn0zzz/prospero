#!/usr/bin/env bash

# Prospero
#
# You should have received a copy of the license along with this program.
#
# Licensed under
# - GNU Affero General Public License V3
# - CeCILL Affero compliant

# Setup database
echo "Setting up database..."
su postgres -c "psql --command=\"DROP DATABASE IF EXISTS prospero_development\""
su postgres -c "psql --command=\"DROP DATABASE IF EXISTS prospero_test\""
su postgres -c "psql --command=\"DROP USER IF EXISTS prospero\""
su postgres -c "psql --command=\"CREATE USER prospero WITH SUPERUSER PASSWORD 'prospero'\""
exit 0
