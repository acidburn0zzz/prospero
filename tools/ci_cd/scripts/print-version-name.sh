#!/usr/bin/env bash

# Prospero
#
# You should have received a copy of the license along with this program.
#
# Licensed under
# - GNU Affero General Public License V3
# - CeCILL Affero compliant

# This script takes a tag name and extracts and prints to the standard output
# the version name.
#
# Usage:
#   print-version-name.sh tag-name>
#
# Exemple:
#
# $ print-version-name.sh v3.0
# => 3.0

# Make script to fail if any command fails
set -e

tag_name=$1

echo $tag_name | sed -e 's/v//'
