#!/usr/bin/env bash

# Prospero
#
# You should have received a copy of the license along with this program.
#
# Licensed under
# - GNU Affero General Public License V3
# - CeCILL Affero compliant

# This script takes a Heroku API key as parameter and prints the associated
# e-mail address.
#
# See https://devcenter.heroku.com/articles/platform-api-reference
#
# Usage:
#   print-heroku-email.sh <heroku-api-key>

# Make script to fail if any command fails
set -e

heroku_api_key=$1

curl \
  --header "Authorization: Bearer $heroku_api_key" \
  --header 'Accept: application/vnd.heroku+json; version=3' \
  --url https://api.heroku.com/account 2> /dev/null | jq -r '.email'
