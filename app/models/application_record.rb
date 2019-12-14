# frozen_string_literal: true

# Prospero
#
# You should have received a copy of the license along with this program.
#
# Licensed under
# - GNU Affero General Public License V3
# - a CeCILL variant affero compliant

# Base model class
#
# see https://guides.rubyonrails.org/active_record_basics.html
class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
end
