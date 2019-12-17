#!/usr/bin/env bash

echo "Installing Rubocop..."
source ~/.rvm/scripts/rvm
cd /srv/prospero
gem install rubocop -v '~> 0.77.0'
