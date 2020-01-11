# frozen_string_literal: true

# Prospero
#
# You should have received a copy of the license along with this program.
#
# Licensed under
# - GNU Affero General Public License V3
# - CeCILL Affero compliant

# Devise mailer tests
describe Devise::Mailer do
  let(:user) { create(:user) }
  let(:token) { random_token }

  context '.confirmation_instructions' do
    it 'is expected to render message' do
      expect do
        described_class
          .confirmation_instructions(user, token)
          .deliver_now
      end.not_to raise_error
    end
  end

  context '.email_changed' do
    it 'is expected to render message' do
      expect do
        described_class
          .email_changed(user)
          .deliver_now
      end.not_to raise_error
    end
  end

  context '.password_change' do
    it 'is expected to render message' do
      expect do
        described_class
          .password_change(user)
          .deliver_now
      end.not_to raise_error
    end
  end

  context '.reset_password_instructions' do
    it 'is expected to render message' do
      expect do
        described_class
          .reset_password_instructions(user, token)
          .deliver_now
      end.not_to raise_error
    end
  end
end
