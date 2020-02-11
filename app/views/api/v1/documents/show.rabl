# frozen_string_literal: true

# Prospero
#
# You should have received a copy of the license along with this program.
#
# Licensed under
# - GNU Affero General Public License V3
# - CeCILL Affero compliant

# Document show JSON template
#
# See https://github.com/nesquena/rabl#usage

object @resource => :document

attribute :id
attribute :name
attribute :body
attribute :parent_id
