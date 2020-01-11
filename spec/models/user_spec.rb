# frozen_string_literal: true

# Prospero
#
# You should have received a copy of the license along with this program.
#
# Licensed under
# - GNU Affero General Public License V3
# - CeCILL Affero compliant

# User model tests
describe User do
  subject { build(:user) }

  it { expect(subject).to validate_presence_of(:full_name) }
end
