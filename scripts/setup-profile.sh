#!/usr/bin/env bash

if [ ! -f ~/prospero ]; then
  ln -nsf /srv/prospero ~/prospero
  echo "cd /srv/prospero" >> ~/.profile
fi
