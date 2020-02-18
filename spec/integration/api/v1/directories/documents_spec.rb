# frozen_string_literal: true

# Prospero
#
# You should have received a copy of the license along with this program.
#
# Licensed under
# - GNU Affero General Public License V3
# - CeCILL Affero compliant

# Directory Documents APIv1 integration tests
describe 'Directory documents tests' do
  context 'List documents' do
    let(:user) { create(:user, :confirmed) }
    let!(:directory) { create(:directory) }
    let!(:subdirectory) { create(:directory, parent: directory) }
    let!(:document1) { create(:document, parent: directory) }
    let!(:document2) { create(:document, parent: subdirectory) }

    before do
      sign_in(user)
      get "/api/v1/directories/#{directory.id}/documents"
    end

    it { expect(response).to have_http_status(:ok) }
    it 'is expected to respond with all documents inside the directory' do
      expect(json(response.body)['documents'].map { |doc| doc['id'] }).to(
        contain_exactly(document1.id, document2.id)
      )
    end
  end
end
