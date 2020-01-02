# frozen_string_literal: true

# Prospero
#
# You should have received a copy of the license along with this program.
#
# Licensed under
# - GNU Affero General Public License V3
# - CeCILL Affero compliant

# Users confirmations APIv1 integration tests
describe 'Users confirmations tests' do
  context 'Confirm e-mail address' do
    let(:user) { create(:user) }
    let(:given_token) { user.confirmation_token }

    before do
      put '/api/v1/users/confirmations', params: {
        token: given_token
      }
    end

    it { expect(response).to have_http_status(:ok) }
    it 'is expected to respond with confirmed user' do
      expect(json(response.body)['user']).to eq(
        'id' => user.id,
        'email' => user.email
      )
    end
    it 'is expected to confirm user email address' do
      expect(user.reload.confirmed_at).to be_present
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
    context 'when given token doest not exist' do
      let(:given_token) { random_token }

      it { expect(response).to have_http_status(:bad_request) }
      it 'is expected to respond with error message' do
        expect(json(response.body)['error']['confirmation_token']).to(
          contain_exactly(translate('errors.messages.invalid'))
        )
      end
      it 'is expected not to confirm user email address' do
        expect(user.reload.confirmed_at).not_to be_present
      end
    end
    context 'when e-mail has already been confirmed' do
      let(:user) { create(:user, :confirmed, confirmation_token: random_token) }

      it { expect(response).to have_http_status(:bad_request) }
      it 'is expected to respond with error message' do
        expect(json(response.body)['error']['email']).to(
          contain_exactly(translate('errors.messages.already_confirmed'))
        )
      end
    end
    context 'when confirmation has expired' do
      let(:more_than_three_days_ago) do
        random_time(from: DateTime.now - 1.month,
                    to: DateTime.now - 4.days)
      end
      let(:user) do
        user = create(:user, confirmation_token: random_token)
        user.update_column(:confirmation_sent_at, more_than_three_days_ago)
        user
      end

      it { expect(response).to have_http_status(:bad_request) }
      it 'is expected to respond with error message' do
        expect(json(response.body)['error']['email']).to contain_exactly(
          translate(
            'errors.messages.confirmation_period_expired',
            period: Devise::TimeInflector.time_ago_in_words(3.days.ago)
          )
        )
      end
    end
  end

  describe 'Re-send confirmation token' do
    let(:user) { create(:user) }
    let(:given_email) { user.email }

    before do
      post '/api/v1/users/confirmations', params: {
        user: {
          email: given_email
        }
      }
    end

    it { expect(response).to have_http_status(:ok) }
    it 'is expected to aknowledge request' do
      expect(json(response.body)['response']).to eq('ok')
    end

    context 'when given e-mail does not exist' do
      let(:given_email) { random_email }

      # Do not send the information that the e-mail doesn't exist in database
      it { expect(response).to have_http_status(:ok) }
      it 'is expected to aknowledge request' do
        expect(json(response.body)['response']).to eq('ok')
      end
    end
  end
end
