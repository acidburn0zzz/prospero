# frozen_string_literal: true

# Prospero
#
# You should have received a copy of the license along with this program.
#
# Licensed under
# - GNU Affero General Public License V3
# - CeCILL Affero compliant

# Users preferences model
class Preference < ApplicationRecord
  validates_inclusion_of :locale, in: I18n.available_locales.map(&:to_s)

  after_initialize :init_locale, if: :new_record?

  private

  def init_locale
    self.locale = I18n.locale
  end
end
