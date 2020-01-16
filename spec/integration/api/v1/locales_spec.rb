# frozen_string_literal: true

# Prospero
#
# You should have received a copy of the license along with this program.
#
# Licensed under
# - GNU Affero General Public License V3
# - CeCILL Affero compliant

# Locales APIv1 integration tests
describe 'Locale tests' do
  context 'Update locale' do
    let(:given_locale) { available_locales.sample }

    before do
      put '/api/v1/locale', params: {
        locale: given_locale
      }
    end

    it { expect(response).to have_http_status(:ok) }
    it 'is expected to respond with updated locale' do
      expect(json(response.body)['locale']).to eq(given_locale)
    end
    it 'is expected to update session cookie' do
      expect(session[:locale]).to eq(given_locale)
    end
  end
end
