# frozen_string_literal: true

# Prospero
#
# You should have received a copy of the license along with this program.
#
# Licensed under
# - GNU Affero General Public License V3
# - CeCILL Affero compliant

# Users passwords APIv1 integration tests
describe 'Passwords recovery tests' do
  context 'Send reset password instructions' do
    let(:user) { create(:user, :confirmed) }
    let(:given_email) { user.email }

    before do
      post '/api/v1/users/passwords', params: {
        user: {
          email: given_email
        }
      }
    end

    it { expect(response).to have_http_status(:ok) }
    it { expect(json(response.body)['response']).to eq('ok') }
    it { expect(user.reload.reset_password_token).to be_present }

    context 'when given e-mail does not exist' do
      let(:given_email) { random_email }

      it { expect(response).to have_http_status(:ok) }
      it { expect(json(response.body)['response']).to eq('ok') }
      it { expect(user.reload.reset_password_token).not_to be_present }
    end
  end

  context 'Reset password' do
    let(:reset_password_token) { random_token }
    let(:digested_token) do
      Devise.token_generator.digest(
        User, :reset_password_token, reset_password_token
      )
    end
    let!(:user) do
      create(:user, :confirmed,
             reset_password_token: digested_token,
             reset_password_sent_at: Time.now)
    end
    let(:given_token) { reset_password_token }
    let(:given_password) { random_password }

    before do
      put '/api/v1/users/passwords', params: {
        token: given_token,
        user: {
          password: given_password
        }
      }
    end

    it { expect(response).to have_http_status(:ok) }
    it { expect(json(response.body)['response']).to eq('ok') }
    it 'is expected to change password' do
      expect(user.reload.valid_password?(given_password)).to be(true)
    end

    context 'when given token is missing' do
      let(:given_token) { '' }

      it { expect(response).to have_http_status(:bad_request) }
      it 'is expected to respond with error message' do
        expect(json(response.body)['error']).to eq(
          translate('errors.messages.param_missing', param: 'token')
        )
      end
    end
    context 'when token is invalid' do
      let(:given_token) { random_token }

      it { expect(response).to have_http_status(:bad_request) }
      it 'is expected to respond with error message' do
        expect(json(response.body)['error']['reset_password_token']).to(
          contain_exactly(translate('errors.messages.invalid'))
        )
      end
      it 'is expected not to change password' do
        expect(user.reload.valid_password?(given_password)).to be(false)
      end
    end
    context 'when the given password is too short' do
      let(:given_password) { 'short' }

      it { expect(response).to have_http_status(:bad_request) }
      it 'is expected to respond with error message' do
        expect(json(response.body)['error']['password']).to(
          contain_exactly(translate('errors.messages.too_short', count: 6))
        )
      end
      it 'is expected not to change password' do
        expect(user.reload.valid_password?(given_password)).to be(false)
      end
    end
  end
end
