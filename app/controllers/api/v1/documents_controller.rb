# frozen_string_literal: true

# Prospero
#
# You should have received a copy of the license along with this program.
#
# Licensed under
# - GNU Affero General Public License V3
# - CeCILL Affero compliant

module Api
  module V1
    # Documents controller
    #
    # This controller handles the endpoints for documents management in
    # Prospero library.
    class DocumentsController < Api::V1::BaseController
      # Create document
      #
      # POSTS /api/v1/documents
      #
      # Parameters:
      #   document[name]      - New document's name
      #   document[body]      - New document's body
      #   document[parent_id] - New document's parent ID
      #
      # Response: the newly created document
      #   {
      #     "document": {
      #       "id": "a48dc549-6e6d-494b-8757-38e6d8e03b1f",
      #       "name": "Aut aut totam sit"
      #       "body": "Alias omnis et. Officiis quasi totam.",
      #       "parent_id": "7e1a7f1d-c5ba-4a29-9641-17b9ff20fc4e"
      #     }
      #   }
      def create
        @resource = Document.new(document_params)
        authorize! :create, @resource
        @resource.save!
        render :'api/v1/documents/show'
      end

      # Show document
      #
      # GET /api/v1/documents/:id
      #
      # Response: the requested document
      #   {
      #     "document": {
      #       "id": "a48dc549-6e6d-494b-8757-38e6d8e03b1f",
      #       "name": "Aut aut totam sit"
      #       "body": "Alias omnis et. Officiis quasi totam.",
      #       "parent_id": "7e1a7f1d-c5ba-4a29-9641-17b9ff20fc4e"
      #     }
      #   }
      def show
        @resource = Document.find(params[:id])
        authorize! :read, @resource
      end

      # Update document
      #
      # PUT /api/v1/documents/:id
      #
      # Parameters:
      #   document[name]      - New name
      #   document[body]      - New body
      #   document[parent_id] - New parent ID
      #
      # Response: the updated document
      #   {
      #     "document": {
      #       "id": "a48dc549-6e6d-494b-8757-38e6d8e03b1f",
      #       "name": "Aut aut totam sit"
      #       "body": "Alias omnis et. Officiis quasi totam.",
      #       "parent_id": "7e1a7f1d-c5ba-4a29-9641-17b9ff20fc4e"
      #     }
      #   }
      def update
        @resource = Document.find(params[:id])
        authorize! :update, @resource
        @resource.update!(document_params)
        render :show
      end

      # Delete document
      #
      # DELETE /api/v1/documents/:id
      #
      # Response: the deleted document
      #   {
      #     "document": {
      #       "id": "a48dc549-6e6d-494b-8757-38e6d8e03b1f",
      #       "name": "Aut aut totam sit"
      #       "body": "Alias omnis et. Officiis quasi totam.",
      #       "parent_id": "7e1a7f1d-c5ba-4a29-9641-17b9ff20fc4e"
      #     }
      #   }
      def destroy
        @resource = Document.find(params[:id])
        authorize! :destroy, @resource
        @resource.destroy!
        render :show
      end

      private

      def document_params
        params.require(:document)
              .permit(:name,
                      :body,
                      :parent_id)
      end
    end
  end
end
