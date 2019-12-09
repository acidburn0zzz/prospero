#!/usr/bin/env bash

# Install Yarn
echo "Installing Yarn..."
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
apt-get update
apt-get install --yes yarn

# Install Node
echo "Installing Node.js..."
curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
apt-get install --yes nodejs

# Install libpq-dev
echo "Installing libpq-dev..."
apt-get install --yes libpq-dev

# Cleanup
echo "Cleaning up..."
apt-get --yes autoremove
