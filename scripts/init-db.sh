#!/usr/bin/env bash

source ~/.rvm/scripts/rvm
cd /srv/prospero
rake db:create db:migrate db:seed db:test:prepare
