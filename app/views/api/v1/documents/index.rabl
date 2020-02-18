# frozen_string_literal: true

# Prospero
#
# You should have received a copy of the license along with this program.
#
# Licensed under
# - GNU Affero General Public License V3
# - CeCILL Affero compliant

# Document index JSON template
#
# See https://github.com/nesquena/rabl#usage

collection @resources, root: 'documents', object_root: false

attribute :id
attribute :name
attribute :parent_id
