# frozen_string_literal: true

# Prospero
#
# You should have received a copy of the license along with this program.
#
# Licensed under
# - GNU Affero General Public License V3
# - CeCILL Affero compliant

# Documents APIv1 integration tests
describe 'Documents tests' do
  context 'Show document' do
    let(:user) { create(:user, :confirmed) }
    let!(:document) { create(:document, parent: create(:directory)) }

    before do
      sign_in(user)
      get "/api/v1/documents/#{document.id}"
    end

    it { expect(response).to have_http_status(:ok) }
    it 'is expected to respond with requested document' do
      expect(json(response.body)['document']['id']).to eq(document.id)
      expect(json(response.body)['document']['name']).to eq(document.name)
      expect(json(response.body)['document']['body']).to eq(document.body)
      expect(json(response.body)['document']['parent_id']).to(
        eq(document.parent_id)
      )
    end
  end

  context 'Create document' do
    let(:user) { create(:user, :confirmed) }
    let!(:directory) { create(:directory) }
    let!(:existing_document) { create(:document, parent: directory) }

    let(:given_name) { random_document_name }
    let(:given_body) { random_document_body }
    let(:given_parent_id) { directory.id }

    before do
      sign_in(user)
      post '/api/v1//documents', params: {
        document: {
          name: given_name,
          body: given_body,
          parent_id: given_parent_id
        }
      }
    end

    it { expect(response).to have_http_status(:ok) }
    it 'is expected to create document' do
      expect(Document.count).to be(2)
    end
    it 'is expected to respond with the created document' do
      expect(json(response.body)['document']['name']).to eq(given_name)
      expect(json(response.body)['document']['body']).to eq(given_body)
      expect(json(response.body)['document']['parent_id']).to eq(directory.id)
    end

    context 'when validation fails' do
      let(:given_name) { existing_document.name }

      it { expect(response).to have_http_status(:bad_request) }
      it 'is expected not to create document' do
        expect(Document.count).to be(1)
      end
    end
  end

  context 'Update document' do
    let(:user) { create(:user, :confirmed) }
    let!(:document_to_update) { create(:document) }
    let(:directory) { create(:directory) }
    let!(:existing_document) { create(:document, parent: directory) }

    let(:given_name) { random_document_name }
    let(:given_body) { random_document_body }
    let(:given_parent_id) { directory.id }

    before do
      sign_in(user)
      put "/api/v1/documents/#{document_to_update.id}", params: {
        document: {
          name: given_name,
          body: given_body,
          parent_id: given_parent_id
        }
      }
    end

    it { expect(response).to have_http_status(:ok) }
    it 'is expected to update the document' do
      expect(document_to_update.reload.name).to eq(given_name)
      expect(document_to_update.reload.body).to eq(given_body)
      expect(document_to_update.reload.parent_id).to eq(given_parent_id)
    end
    it 'is expected to respond with updated document' do
      expect(json(response.body)['document']['name']).to eq(given_name)
      expect(json(response.body)['document']['body']).to eq(given_body)
      expect(json(response.body)['document']['parent_id']).to(
        eq(given_parent_id)
      )
    end

    context 'when validation fails' do
      let(:given_name) { existing_document.name }

      it { expect(response).to have_http_status(:bad_request) }
      it 'is expected not to update the document' do
        expect(document_to_update.reload.name).not_to eq(given_name)
        expect(document_to_update.reload.body).not_to eq(given_body)
        expect(document_to_update.reload.parent_id).not_to eq(given_parent_id)
      end
    end
  end

  context 'Delete document' do
    let(:user) { create(:user, :confirmed) }
    let(:document_to_destroy) { create(:document) }

    before do
      sign_in(user)
      delete "/api/v1/documents/#{document_to_destroy.id}"
    end

    it { expect(response).to have_http_status(:ok) }
    it 'is expected to delete document from database' do
      expect(Document.find_by_id(document_to_destroy.id)).not_to be_present
    end
    it 'is expected to respond with deleted document' do
      expect(json(response.body)['document']['name']).to(
        eq(document_to_destroy.name)
      )
    end
  end
end
