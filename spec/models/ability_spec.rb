# frozen_string_literal: true

# Prospero
#
# You should have received a copy of the license along with this program.
#
# Licensed under
# - GNU Affero General Public License V3
# - CeCILL Affero compliant

# User abilities tests
describe Ability do
  context 'Users' do
    context 'create' do
      let(:object) { build(:user) }

      it 'is expected to authorize anonymous user' do
        expect(described_class.new(nil).can?(:create, object)).to be(true)
      end
    end

    context 'read' do
      let(:object) { create(:user) }
      let(:another_user) { create(:user) }

      it 'is expected to authorize the same user' do
        expect(described_class.new(object).can?(:read, object)).to be(true)
      end
      it 'is expected to authorize the other users' do
        expect(
          described_class.new(another_user).can?(:read, object)
        ).to be(true)
      end
      it 'is expected not to authorize anonymous user' do
        expect(described_class.new(nil).can?(:read, object)).to be(false)
      end
    end

    context 'update' do
      let(:object) { create(:user) }
      let(:another_user) { create(:user) }

      it 'is expected to authorize the same user' do
        expect(described_class.new(object).can?(:update, object)).to be(true)
      end
      it 'is expected not to authorize the other users' do
        expect(
          described_class.new(another_user).can?(:update, object)
        ).to be(false)
      end
      it 'is expected not to authorize anonymous user' do
        expect(described_class.new(nil).can?(:update, object)).to be(false)
      end
    end

    context 'destroy' do
      let(:object) { create(:user) }
      let(:another_user) { create(:user) }

      it 'is expected to authorize the same user' do
        expect(described_class.new(object).can?(:destroy, object)).to be(true)
      end
      it 'is expected not to authorize the other users' do
        expect(
          described_class.new(another_user).can?(:destroy, object)
        ).to be(false)
      end
      it 'is expected not to authorize anonymous user' do
        expect(described_class.new(nil).can?(:destroy, object)).to be(false)
      end
    end
  end
end
