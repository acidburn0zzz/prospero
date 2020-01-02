#!/usr/bin/env bash

# Prospero
#
# You should have received a copy of the license along with this program.
#
# Licensed under
# - GNU Affero General Public License V3
# - CeCILL Affero compliant

# This script takes a merge commit message as parameter and prints to the
# standard output the name of the merge's source branch.
#
# Usage:
#   print-merge-source.sh <merge-commit-title>

# Make script to fail if any command fails
set -e

commit_title=$1

echo $commit_title | sed -e "s|Merge branch '\([^']*\)'.*|\1|"
