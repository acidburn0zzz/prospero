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
  context 'List users' do
    let!(:user1) { create(:user, :confirmed) }
    let!(:user2) { create(:user) }
    let!(:user3) { create(:user) }

    before do
      sign_in(user1)
      get '/api/v1/users'
    end

    it { expect(response).to have_http_status(:ok) }
    it 'is expected to response with all users in the database' do
      expect(json(response.body)['users'].map { |user| user['id'] }).to(
        contain_exactly(user1.id, user2.id, user3.id)
      )
    end
  end

  context 'Create user' do
    let!(:existing_user) { create(:user) }
    let(:given_email) { random_email }
    let(:given_password) { random_password }
    let(:given_full_name) { random_name }

    before do
      post '/api/v1/users', params: {
        user: {
          email: given_email,
          password: given_password,
          full_name: given_full_name
        }
      }
    end

    it { expect(response).to have_http_status(:ok) }
    it 'is expected to respond with created user' do
      expect(json(response.body)['user']['email']).to eq(given_email)
      expect(json(response.body)['user']['full_name']).to eq(given_full_name)
    end
    it 'is expected to create a new user' do
      expect(User.count).to eq(2)
    end

    context 'when e-mail already exists' do
      let(:given_email) { existing_user.email }

      it { expect(response).to have_http_status(:bad_request) }
      it 'is expected to respond with error message' do
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

  context 'Show user' do
    let(:logged_user) { create(:user, :confirmed) }
    let(:user_to_show) { create(:user) }

    before do
      sign_in(logged_user)
      get "/api/v1/users/#{user_to_show.id}"
    end

    it { expect(response).to have_http_status(:ok) }
    it 'is expected to respond with requested user' do
      expect(json(response.body)['user']).to eq(
        'id' => user_to_show.id,
        'email' => user_to_show.email,
        'full_name' => user_to_show.full_name
      )
    end
  end

  context 'Update user' do
    let(:old_email) { random_email }
    let(:given_email) { random_email }
    let(:given_password) { random_password }
    let(:given_full_name) { random_name }

    let(:logged_user) { create(:user, :confirmed, email: old_email) }
    let(:user_to_update) { logged_user }
    let(:not_logged_user) { create(:user) }

    before do
      sign_in(logged_user)
      put "/api/v1/users/#{user_to_update.id}", params: {
        user: {
          email: given_email,
          password: given_password,
          full_name: given_full_name
        }
      }
    end

    it { expect(response).to have_http_status(:ok) }
    it 'is expected to respond with updated user still having old email' do
      expect(json(response.body)['user']).to eq(
        'id' => user_to_update.id,
        'email' => old_email,
        'full_name' => given_full_name
      )
    end
    it 'is expected to set unconfirmed_email with new email' do
      expect(user_to_update.reload.unconfirmed_email).to eq(given_email)
    end
    it 'is expected to change password' do
      expect(user_to_update.reload.valid_password?(given_password)).to be(true)
    end

    context 'when trying to update another user' do
      let(:user_to_update) { not_logged_user }

      it { expect(response).to have_http_status(:forbidden) }
      it 'is expected to respond with error message' do
        expect(json(response.body)['error']).to(
          eq(translate('errors.messages.forbidden'))
        )
      end
    end
    context 'when new e-mail already exists' do
      let(:given_email) { not_logged_user.email }

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
    let(:given_password) { user_password }

    let(:logged_user) { create(:user, :confirmed, password: user_password) }
    let(:user_to_delete) { logged_user }
    let(:not_logged_user) { create(:user) }

    before do
      sign_in(logged_user)
      delete "/api/v1/users/#{user_to_delete.id}", params: {
        user: {
          password: given_password
        }
      }
    end

    it { expect(response).to have_http_status(:ok) }
    it 'is expected to respond with deleted user' do
      expect(json(response.body)['user']).to eq(
        'id' => user_to_delete.id,
        'email' => user_to_delete.email,
        'full_name' => user_to_delete.full_name
      )
    end
    it 'is expected to delete user from database' do
      expect(User.find_by_id(user_to_delete.id)).not_to be_present
    end

    context 'when trying to delete another user' do
      let(:user_to_delete) { not_logged_user }

      it { expect(response).to have_http_status(:forbidden) }
      it 'is expected to respond with error message' do
        expect(json(response.body)['error']).to(
          eq(translate('errors.messages.forbidden'))
        )
      end
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
        expect(user_to_delete).to be_persisted
      end
    end
  end
end
