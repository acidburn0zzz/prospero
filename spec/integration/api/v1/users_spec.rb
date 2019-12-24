# frozen_string_literal: true

# Prospero
#
# You should have received a copy of the license along with this program.
#
# Licensed under
# - GNU Affero General Public License V3
# - CeCILL Affero compliant

# Users APIv1 integration tests
describe 'Users tests' do
  context 'Create user' do
    let!(:existing_user) { create(:user) }
    let(:given_email) { random_email }
    let(:given_password) { random_password }

    before do
      post '/api/v1/users', params: {
        user: {
          email: given_email,
          password: given_password
        }
      }
    end

    it { expect(response).to have_http_status(:ok) }
    it 'is expected to respond with created user' do
      expect(json(response.body)['user']['email']).to eq(given_email)
    end
    it 'is expected to create a new user' do
      expect(User.count).to eq(2)
    end

    context 'when e-mail already exists' do
      let(:given_email) { existing_user.email }

      it { expect(response).to have_http_status(:bad_request) }
      it 'is eexpected to respond with error message' do
        expect(json(response.body)['error']['email']).to(
          contain_exactly(translate('errors.messages.taken'))
        )
      end
      it 'is expected not to create new user' do
        expect(User.count).to eq(1)
      end
    end
    context 'when e-mail is invalid' do
      let(:given_email) { 'invalid_email' }

      it { expect(response).to have_http_status(:bad_request) }
      it 'is expected to respond with error message' do
        expect(json(response.body)['error']['email']).to(
          contain_exactly(translate('errors.messages.invalid'))
        )
      end
      it 'is expected not to create new user' do
        expect(User.count).to eq(1)
      end
    end
    context 'when password is too short' do
      let(:given_password) { 'short' }

      it { expect(response).to have_http_status(:bad_request) }
      it 'is expected to respond with error message' do
        expect(json(response.body)['error']['password']).to(
          contain_exactly(translate('errors.messages.too_short', count: 6))
        )
      end
      it 'is expected not to create new user' do
        expect(User.count).to eq(1)
      end
    end
  end

  context 'Update user' do
    let(:user) { create(:user, :confirmed, email: old_email) }
    let(:old_email) { random_email }
    let(:given_email) { random_email }
    let(:given_password) { random_password }

    let!(:another_user) { create(:user) }

    before do
      sign_in(user)
      put '/api/v1/users', params: {
        user: {
          email: given_email,
          password: given_password
        }
      }
    end

    it { expect(response).to have_http_status(:ok) }
    it 'is expected to respond with updated user still having old email' do
      expect(json(response.body)['user']).to eq(
        'id' => user.id,
        'email' => old_email
      )
    end
    it 'is expected to set unconfirmed_email with new email' do
      expect(user.reload.unconfirmed_email).to eq(given_email)
    end
    it 'is expected to change password' do
      expect(user.reload.valid_password?(given_password)).to be(true)
    end

    context 'when new e-mail already exists' do
      let(:given_email) { another_user.email }

      it { expect(response).to have_http_status(:bad_request) }
      it 'is expected to respond with error message' do
        expect(json(response.body)['error']['email']).to(
          contain_exactly(translate('errors.messages.taken'))
        )
      end
    end
    context 'when new e-mail is invalid' do
      let(:given_email) { 'invalid_email' }

      it { expect(response).to have_http_status(:bad_request) }
      it 'is expected to respond with error message' do
        expect(json(response.body)['error']['email']).to(
          contain_exactly(translate('errors.messages.invalid'))
        )
      end
    end
    context 'when new password is too short' do
      let(:given_password) { 'short' }

      it { expect(response).to have_http_status(:bad_request) }
      it 'is expected to respond with error message' do
        expect(json(response.body)['error']['password']).to(
          contain_exactly(translate('errors.messages.too_short', count: 6))
        )
      end
    end
  end

  context 'Delete user' do
    let(:user_password) { random_password }
    let(:user) { create(:user, :confirmed, password: user_password) }
    let(:given_password) { user_password }

    before do
      sign_in(user)
      delete '/api/v1/users', params: {
        user: {
          password: given_password
        }
      }
    end

    it { expect(response).to have_http_status(:ok) }
    it 'is expected to respond with deleted user' do
      expect(json(response.body)['user']).to eq(
        'id' => user.id,
        'email' => user.email
      )
    end
    it 'is expected to delete user from database' do
      expect(user).not_to be_persisted
    end

    context 'when password is wrong' do
      let(:given_password) { random_password }

      it { expect(response).to have_http_status(:bad_request) }
      it 'is expected to respond with error message' do
        expect(json(response.body)['error']).to(
          eq(translate('errors.password_missmatch'))
        )
      end
      it 'is expected not to delete user from database' do
        expect(user).to be_persisted
      end
    end
  end
end
