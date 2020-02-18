# frozen_string_literal: true

# Prospero
#
# You should have received a copy of the license along with this program.
#
# Licensed under
# - GNU Affero General Public License V3
# - CeCILL Affero compliant

# Library file model tests
describe LibraryFile do
  subject { build(:library_file) }

  let(:directory) { create(:directory) }
  let(:document) { create(:document) }

  it { expect(subject).to validate_presence_of(:name) }
  it { expect(subject).to validate_uniqueness_of(:name).scoped_to(:parent_id) }
  it { expect(subject).to allow_value(directory.id).for(:parent_id) }
  it { expect(subject).not_to allow_value(document.id).for(:parent_id) }
end
