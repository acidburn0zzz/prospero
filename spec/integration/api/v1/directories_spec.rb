# frozen_string_literal: true

# Prospero
#
# You should have received a copy of the license along with this program.
#
# Licensed under
# - GNU Affero General Public License V3
# - CeCILL Affero compliant

# Directories APIv1 integration tests
describe 'Directories tests' do
  context 'List directories' do
    let(:user) { create(:user, :confirmed) }

    let!(:directory1) { create(:directory) }
    let!(:directory2) { create(:directory) }
    let!(:directory3) { create(:directory, parent: directory2) }
    let!(:directory4) { create(:directory) }
    let!(:directory5) { create(:directory) }
    let!(:directory6) { create(:directory, parent: directory3) }
    let!(:directory7) { create(:directory, parent: directory6) }
    let!(:directory8) { create(:directory, parent: directory7) }
    let!(:directory9) { create(:directory) }

    before do
      sign_in(user)
      get '/api/v1/directories'
    end

    it { expect(response).to have_http_status(:ok) }
    it 'is expected to respond with all directories' do
      expect(json(response.body)['directories'].map { |dir| dir['id'] }).to(
        contain_exactly(directory1.id, directory2.id, directory3.id,
                        directory4.id, directory5.id, directory6.id,
                        directory7.id, directory8.id, directory9.id)
      )
    end
  end

  context 'Create directory' do
    let(:user) { create(:user, :confirmed) }
    let!(:existing_directory) { create(:directory, parent_id: nil) }

    let(:given_name) { random_name }
    let(:given_parent_id) { existing_directory.id }

    before do
      sign_in(user)
      post '/api/v1/directories', params: {
        directory: {
          name: given_name,
          parent_id: given_parent_id
        }
      }
    end

    it { expect(response).to have_http_status(:ok) }
    it 'is expected to create a new directory' do
      expect(Directory.count).to eq(2)
    end
    it 'is expected to respond with created directory' do
      expect(json(response.body)['directory']['name']).to eq(given_name)
      expect(json(response.body)['directory']['parent_id']).to(
        eq(given_parent_id)
      )
    end

    context 'when validation fails' do
      let(:given_name) { existing_directory.name }
      let(:given_parent_id) { nil }

      it { expect(response).to have_http_status(:bad_request) }
      it 'is expected not to create a new directory' do
        expect(Directory.count).to eq(1)
      end
    end
  end

  context 'Update directory' do
    let(:user) { create(:user, :confirmed) }
    let!(:directory_to_update) { create(:directory, parent_id: nil) }
    let!(:another_directory) { create(:directory, parent_id: nil) }

    let(:given_name) { random_name }
    let(:given_parent_id) { another_directory.id }

    before do
      sign_in(user)
      put "/api/v1/directories/#{directory_to_update.id}", params: {
        directory: {
          name: given_name,
          parent_id: given_parent_id
        }
      }
    end

    it { expect(response).to have_http_status(:ok) }
    it 'is expected to update directory' do
      expect(directory_to_update.reload.name).to eq(given_name)
      expect(directory_to_update.reload.parent_id).to eq(given_parent_id)
    end
    it 'is expected to respond with updated directory' do
      expect(json(response.body)['directory']['name']).to eq(given_name)
      expect(json(response.body)['directory']['parent_id']).to(
        eq(given_parent_id)
      )
    end

    context 'when validation fails' do
      let(:given_name) { another_directory.name }
      let(:given_parent_id) { nil }

      it { expect(response).to have_http_status(:bad_request) }
      it 'is expected not to update directory' do
        expect(directory_to_update.reload.name).not_to eq(given_name)
        expect(directory_to_update.reload.parent_id).to be_nil
      end
    end
  end

  context 'Delete directory' do
    let(:user) { create(:user, :confirmed) }
    let!(:directory_to_destroy) { create(:directory) }

    before do
      sign_in(user)
      delete "/api/v1/directories/#{directory_to_destroy.id}"
    end

    it { expect(response).to have_http_status(:ok) }
    it 'is expected to delete directory from database' do
      expect(Directory.find_by_id(directory_to_destroy.id)).not_to be_present
    end
    it 'is expected to respond with deleted directory' do
      expect(json(response.body)['directory']['name']).to(
        eq(directory_to_destroy.name)
      )
    end
  end
end
