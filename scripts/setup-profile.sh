#!/usr/bin/env bash

echo "Setting up profile..."
if [ ! -f ~/prospero ]; then
  ln -nsf /srv/prospero ~/prospero
  echo "cd /srv/prospero" >> ~/.profile
fi
