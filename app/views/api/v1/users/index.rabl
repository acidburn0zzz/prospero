# frozen_string_literal: true

# Prospero
#
# You should have received a copy of the license along with this program.
#
# Licensed under
# - GNU Affero General Public License V3
# - CeCILL Affero compliant

# User index JSON template
#
# See https://github.com/nesquena/rabl#usage

collection @resources, root: 'users', object_root: false

attribute :id
attribute :full_name
