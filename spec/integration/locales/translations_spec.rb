# frozen_string_literal: true

# Prospero
#
# You should have received a copy of the license along with this program.
#
# Licensed under
# - GNU Affero General Public License V3
# - CeCILL Affero compliant

# Translations integration tests
describe 'Translations' do
  I18n.available_locales.each do |locale|
    context "when locale is #{locale}" do
      before do
        get "/locales/#{locale}/translation.json"
      end

      it { expect(response).to have_http_status(:ok) }
    end
  end
end
