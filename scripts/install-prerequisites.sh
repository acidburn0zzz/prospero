#!/usr/bin/env bash

# Install Yarn
yarn --version > /dev/null 2>&1
if [ $? -ne 0 ]
then
  echo "Installing Yarn..."
  curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
  echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
  apt-get update
  apt-get install -y yarn
fi

# Install Node
node --version > /dev/null 2>&1
if [ $? -ne 0 ]
then
  echo "Installing Node.js..."
  curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
  apt-get install -y nodejs
fi

# Install libpq-dev
dpkg -l libpq-dev > /dev/null 2>&1
if [ $? -ne 0 ]
then
  apt-get install -y libpq-dev
fi


# Cleanup
apt-get -y autoremove
