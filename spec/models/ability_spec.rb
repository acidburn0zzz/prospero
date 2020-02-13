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

    context 'list' do
      let(:user) { create(:user) }

      it 'is expected to authorize listing directories' do
        expect(described_class.new(user).can?(:list, User)).to be(true)
      end
    end

    context 'read' do
      let(:user) { create(:user) }
      let(:another_user) { create(:user) }

      it 'is expected to authorize the same user' do
        expect(described_class.new(user).can?(:read, user)).to be(true)
      end
      it 'is expected to authorize the other users' do
        expect(
          described_class.new(user).can?(:read, another_user)
        ).to be(true)
      end
      it 'is expected not to authorize anonymous user' do
        expect(described_class.new(nil).can?(:read, user)).to be(false)
      end
    end

    context 'update' do
      let(:user) { create(:user) }
      let(:another_user) { create(:user) }

      it 'is expected to authorize the same user' do
        expect(described_class.new(user).can?(:update, user)).to be(true)
      end
      it 'is expected not to authorize the other users' do
        expect(
          described_class.new(user).can?(:update, another_user)
        ).to be(false)
      end
      it 'is expected not to authorize anonymous user' do
        expect(described_class.new(nil).can?(:update, user)).to be(false)
      end
    end

    context 'destroy' do
      let(:user) { create(:user) }
      let(:another_user) { create(:user) }

      it 'is expected to authorize the same user' do
        expect(described_class.new(user).can?(:destroy, user)).to be(true)
      end
      it 'is expected not to authorize the other users' do
        expect(
          described_class.new(user).can?(:destroy, another_user)
        ).to be(false)
      end
      it 'is expected not to authorize anonymous user' do
        expect(described_class.new(nil).can?(:destroy, user)).to be(false)
      end
    end
  end

  context 'Preferences' do
    context 'read' do
      let(:user) { create(:user) }
      let(:preference) { user.preference }
      let(:another_user) { create(:user) }

      it 'is expected to authorize the same user' do
        expect(described_class.new(user).can?(:read, preference)).to be(true)
      end
      it 'is expected not to authorize the other users' do
        expect(
          described_class.new(another_user).can?(:read, preference)
        ).to be(false)
      end
      it 'is expected not to authorize anonymous user' do
        expect(described_class.new(nil).can?(:read, preference)).to be(false)
      end
    end

    context 'update' do
      let(:user) { create(:user) }
      let(:preference) { user.preference }
      let(:another_user) { create(:user) }

      it 'is expected to authorize the same user' do
        expect(described_class.new(user).can?(:update, preference)).to be(true)
      end
      it 'is expected not to authorize the other users' do
        expect(
          described_class.new(another_user).can?(:update, preference)
        ).to be(false)
      end
      it 'is expected not to authorize anonymous user' do
        expect(described_class.new(nil).can?(:update, preference)).to be(false)
      end
    end
  end

  context 'Directory' do
    context 'list' do
      let(:user) { create(:user) }

      it 'is expected to authorize listing directories' do
        expect(described_class.new(user).can?(:list, Directory)).to be(true)
      end
    end

    context 'create' do
      let(:user) { create(:user) }
      let(:directory) { build(:directory) }

      it 'is expected to authorize listing directories' do
        expect(described_class.new(user).can?(:create, directory)).to be(true)
      end
    end

    context 'read' do
      let(:user) { create(:user) }
      let(:directory) { build(:directory) }

      it 'is expected to authorize listing directories' do
        expect(described_class.new(user).can?(:read, directory)).to be(true)
      end
    end

    context 'update' do
      let(:user) { create(:user) }
      let(:directory) { build(:directory) }

      it 'is expected to authorize listing directories' do
        expect(described_class.new(user).can?(:update, directory)).to be(true)
      end
    end

    context 'destroy' do
      let(:user) { create(:user) }
      let(:directory) { build(:directory) }

      it 'is expected to authorize listing directories' do
        expect(described_class.new(user).can?(:destroy, directory)).to be(true)
      end
    end
  end

  context 'Documents' do
    context 'list' do
      let(:user) { create(:user) }

      it 'is expected to authorize listing directories' do
        expect(described_class.new(user).can?(:list, Document)).to be(true)
      end
    end

    context 'create' do
      let(:user) { create(:user) }
      let(:document) { build(:document) }

      it 'is expected to authorize listing directories' do
        expect(described_class.new(user).can?(:create, document)).to be(true)
      end
    end

    context 'read' do
      let(:user) { create(:user) }
      let(:document) { build(:document) }

      it 'is expected to authorize listing directories' do
        expect(described_class.new(user).can?(:read, document)).to be(true)
      end
    end

    context 'update' do
      let(:user) { create(:user) }
      let(:document) { build(:document) }

      it 'is expected to authorize listing directories' do
        expect(described_class.new(user).can?(:update, document)).to be(true)
      end
    end

    context 'destroy' do
      let(:user) { create(:user) }
      let(:document) { build(:document) }

      it 'is expected to authorize listing directories' do
        expect(described_class.new(user).can?(:destroy, document)).to be(true)
      end
    end
  end
end
