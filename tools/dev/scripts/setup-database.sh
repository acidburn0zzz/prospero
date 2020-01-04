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
su postgres -c "psql --command=\"CREATE USER prospero PASSWORD 'prospero'\""
su postgres -c "psql --command=\"CREATE DATABASE prospero_development OWNER prospero ENCODING UTF8\""
su postgres -c "psql --command=\"CREATE DATABASE prospero_test OWNER prospero ENCODING UTF8\""
su postgres -c "psql --command=\"UPDATE pg_language SET lanpltrusted = true WHERE lanname = 'c'\" prospero_development"
su postgres -c "psql --command=\"UPDATE pg_language SET lanpltrusted = true WHERE lanname = 'c'\" prospero_test"
exit 0
