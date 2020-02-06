# frozen_string_literal: true

# Prospero
#
# You should have received a copy of the license along with this program.
#
# Licensed under
# - GNU Affero General Public License V3
# - CeCILL Affero compliant

# Home page integration tests
describe 'Home' do
  before do
    get '/'
  end

  it { expect(response).to have_http_status(:redirect) }

  I18n.available_locales.each do |locale|
    context "when locale is #{locale}" do
      before do
        get "/#{locale}"
      end

      it { expect(response).to have_http_status(:ok) }
    end
  end

  context 'when locale is invalid' do
    before do
      get '/invalid'

      it { expect(response).to have_http_status(:not_found) }
    end
  end
end
