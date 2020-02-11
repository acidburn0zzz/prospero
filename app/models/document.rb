# frozen_string_literal: true

# Prospero
#
# You should have received a copy of the license along with this program.
#
# Licensed under
# - GNU Affero General Public License V3
# - CeCILL Affero compliant

# A document in Prospero library
#
# See also LibraryFile
class Document < LibraryFile
  validates_presence_of :body,
                        :parent
end
