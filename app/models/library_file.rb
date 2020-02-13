# frozen_string_literal: true

# Prospero
#
# You should have received a copy of the license along with this program.
#
# Licensed under
# - GNU Affero General Public License V3
# - CeCILL Affero compliant

# A file in Prospero library
#
# A file can be a document or a document's folder.
class LibraryFile < ApplicationRecord
  belongs_to :parent, class_name: 'LibraryFile', optional: true

  validates_presence_of :name

  validates_uniqueness_of :name, scope: :parent_id

  validate :validate_parent_is_directory, if: :parent_id?

  private

  def validate_parent_is_directory
    return if parent.present? && parent.is_a?(Directory)

    errors.add(:parent_id, I18n.translate('errors.messages.invalid'))
  end
end
