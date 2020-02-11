# frozen_string_literal: true

# Prospero
#
# You should have received a copy of the license along with this program.
#
# Licensed under
# - GNU Affero General Public License V3
# - CeCILL Affero compliant

# Directory Files APIv1 integration tests
describe 'Directory files tests' do
  context 'List files' do
    let(:user) { create(:user, :confirmed) }
    let!(:directory) { create(:directory) }
    let!(:subdirectory) { create(:directory, parent: directory) }
    let!(:document1) { create(:document, parent: directory) }
    let!(:document2) { create(:document, parent: subdirectory) }

    before do
      sign_in(user)
      get "/api/v1/directories/#{directory.id}/files"
    end

    it { expect(response).to have_http_status(:ok) }
    it 'is expected to respond with all files inside the directory' do
      expect(json(response.body)['files'].map { |doc| doc['id'] }).to(
        contain_exactly(subdirectory.id, document1.id)
      )
    end
  end
end
