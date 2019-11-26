#!/usr/bin/env bash

source ~/.rvm/scripts/rvm
cd /srv/prospero
rake db:version > /dev/null 2>&1
if [ $? -ne 0 ]
then
  rake db:create
fi
rake db:migrate
rake db:test:prepare
