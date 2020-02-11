# frozen_string_literal: true

# Prospero
#
# You should have received a copy of the license along with this program.
#
# Licensed under
# - GNU Affero General Public License V3
# - CeCILL Affero compliant

# Directory model tests
describe Directory do
  subject { build(:directory) }

  context '#documents' do
    subject { create(:directory) }

    let!(:child1) { create(:document, parent: subject) }
    let!(:child2) { create(:directory, parent: subject) }
    let!(:child3) { create(:directory, parent: subject) }
    let!(:grandchild1) { create(:document, parent: child3) }
    let!(:grandchild2) { create(:directory, parent: child3) }
    let!(:great_grandchild1) { create(:document, parent: grandchild2) }

    it 'is expected to contain all descendants' do
      expect(subject.documents).to contain_exactly(child1,
                                                   grandchild1,
                                                   great_grandchild1)
    end
  end
end
