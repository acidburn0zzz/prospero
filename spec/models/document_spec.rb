# frozen_string_literal: true

# Prospero
#
# You should have received a copy of the license along with this program.
#
# Licensed under
# - GNU Affero General Public License V3
# - CeCILL Affero compliant

# Document model tests
describe do
  subject { build(:document) }

  it { expect(subject).to validate_presence_of(:body) }
  it { expect(subject).to validate_presence_of(:parent) }
end
