# frozen_string_literal: true

# Prospero
#
# You should have received a copy of the license along with this program.
#
# Licensed under
# - GNU Affero General Public License V3
# - CeCILL Affero compliant

# Home page integration tests
context 'Home' do
  before do
    get '/'
  end

  it { expect(response).to have_http_status(:ok) }
end
