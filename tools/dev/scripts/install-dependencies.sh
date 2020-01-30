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
cd ~/prospero
gem install rubocop -v '~> 0.77.0'
gem install foreman
gem install bundler:2.0.2
bundle install
yarn install
