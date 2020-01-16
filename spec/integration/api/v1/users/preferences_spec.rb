# frozen_string_literal: true

# Prospero
#
# You should have received a copy of the license along with this program.
#
# Licensed under
# - GNU Affero General Public License V3
# - CeCILL Affero compliant

# Users preferences APIv1 integration tests
describe 'Users preferences tests' do
  context 'Show preferences' do
    let(:logged_user) { create(:user, :confirmed) }
    let(:not_logged_user) { create(:user, :confirmed) }
    let(:user_to_show_preference) { logged_user }

    before do
      sign_in(logged_user)
      get "/api/v1/users/#{user_to_show_preference.id}/preference"
    end

    it { expect(response).to have_http_status(:ok) }
    it "is expected to respond with requested user's preference" do
      expect(json(response.body)['preference']).to eq(
        'locale' => user_to_show_preference.preference.locale
      )
    end

    context "when trying to show another user's preference" do
      let(:user_to_show_preference) { not_logged_user }

      it { expect(response).to have_http_status(:forbidden) }
      it 'is expected to respond with error message' do
        expect(json(response.body)['error']).to(
          eq(translate('errors.messages.forbidden'))
        )
      end
    end
  end

  context 'Update preferences' do
    let(:given_locale) { available_locales.sample }

    let(:logged_user) { create(:user, :confirmed) }
    let(:not_logged_user) { create(:user, :confirmed) }
    let(:user_to_update_preference) { logged_user }

    before do
      sign_in(logged_user)
      put "/api/v1/users/#{user_to_update_preference.id}/preference", params: {
        preference: {
          locale: given_locale
        }
      }
    end

    it { expect(response).to have_http_status(:ok) }
    it "is expected to respond with updated user's preference" do
      expect(json(response.body)['preference']).to eq(
        'locale' => given_locale
      )
    end
    it "is expected to update user's preference" do
      expect(user_to_update_preference.reload.preference.locale).to(
        eq(given_locale)
      )
    end

    context "when trying to show another user's preference" do
      let(:user_to_update_preference) { not_logged_user }

      it { expect(response).to have_http_status(:forbidden) }
      it 'is expected to respond with error message' do
        expect(json(response.body)['error']).to(
          eq(translate('errors.messages.forbidden'))
        )
      end
    end
  end
end
