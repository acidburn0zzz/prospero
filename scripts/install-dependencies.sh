#!/usr/bin/env bash

# Install prospero dependencies
echo "Installing dependencies..."
source ~/.rvm/scripts/rvm
cd /srv/prospero
gem install bundler && bundle install
yarn
