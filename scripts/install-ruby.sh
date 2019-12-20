#!/usr/bin/env bash

# Install Ruby 2.6.5 using RVM
rvm --version > /dev/null 2>&1
if [ $? -ne 0 ]
then
  echo "Installing RVM..."
  gpg --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
  curl -sSL https://get.rvm.io | bash -s stable
  source ~/.rvm/scripts/rvm
fi
echo "Installing Ruby..."
rvm install ruby-2.6.5
