# frozen_string_literal: true

# Prospero
#
# You should have received a copy of the license along with this program.
#
# Licensed under
# - GNU Affero General Public License V3
# - CeCILL Affero compliant

# Auth APIv1 integration tests
describe 'Authentication tests' do
  context 'Sign in' do
    let(:user_password) { random_password }
    let(:user) { create(:user, :confirmed, password: user_password) }
    let(:given_email) { user.email }
    let(:given_password) { user_password }

    before do
      post '/api/v1/auth', params: {
        user: {
          email: given_email,
          password: given_password
        }
      }
    end

    it { expect(response).to have_http_status(:ok) }
    it 'is expected to respond with signed in user' do
      expect(json(response.body)['user']['id']).to eq(user.id)
    end
    it 'is expected to create session cookie' do
      expect(session['warden.user.user.key']).to include([user.id])
    end

    context 'when e-mail doest not exist' do
      let(:given_email) { random_email }

      it { expect(response).to have_http_status(:unauthorized) }
      it 'is expected to respond with error message' do
        expect(json(response.body)['error']).to eq(
          translate('devise.failure.invalid')
        )
      end
    end
    context 'when password is wrong' do
      let(:given_password) { random_password }

      it { expect(response).to have_http_status(:unauthorized) }
      it 'is expected to respond with error message' do
        expect(json(response.body)['error']).to eq(
          translate('devise.failure.invalid')
        )
      end
    end
    context 'when user has not been confirmed' do
      let(:user) { create(:user, password: user_password) }

      it { expect(response).to have_http_status(:unauthorized) }
      it 'is expected to respond with error message' do
        expect(json(response.body)['error']).to(
          eq(translate('devise.failure.unconfirmed'))
        )
      end
    end
  end

  context 'Sign out' do
    let(:user) { create(:user, :confirmed) }

    before do
      sign_in(user)
      delete '/api/v1/auth'
    end

    it { expect(response).to have_http_status(:ok) }
    it 'is expected to respond with signed out user' do
      expect(json(response.body)['user']['id']).to eq(user.id)
    end
    it 'is expected to delete session cookie' do
      expect(session['warden.user.user.key']).not_to be_present
    end
  end
end
