#!/usr/bin/env bash

# Prospero
#
# You should have received a copy of the license along with this program.
#
# Licensed under
# - GNU Affero General Public License V3
# - CeCILL Affero compliant

# Install prospero dependencies
echo "Installing dependencies..."
source ~/.rvm/scripts/rvm
cd /srv/prospero
gem install rubocop --version '~> 0.80.0'
gem install foreman
gem install bundler --version '~> 2.0'
bundle config --local without 'alpine'
bundle install
yarn install
