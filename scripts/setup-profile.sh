#!/usr/bin/env bash

# Prospero
#
# You should have received a copy of the license along with this program.
#
# Licensed under
# - GNU Affero General Public License V3
# - CeCILL Affero compliant

echo "Setting up profile..."
if [ ! -f ~/prospero ]; then
  ln -nsf /srv/prospero ~/prospero
  echo "cd /srv/prospero" >> ~/.profile
fi
