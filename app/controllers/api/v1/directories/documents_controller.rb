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
    module Directories
      # Documents controller
      #
      # This controller handles the endpoints for management of documents inside
      # a given directory in Prospero library.
      class DocumentsController < Api::V1::BaseController
        # List documents inside a directory
        #
        # GET /api/v1/directories/:id/documents
        #
        # Response: list of documents inside the directory
        #   {
        #     "documents": [
        #       {
        #         "id": "a48dc549-6e6d-494b-8757-38e6d8e03b1f",
        #         "name": "Aut aut totam sit",
        #         "parent_id": "20ab6b4f-2ba7-45c8-9364-4b8edd2c6d4b"
        #       },
        #       {
        #         "id": "13cca62f-4ad0-4537-b19a-5de0154ec403",
        #         "name": "Id ea aliquid excepturi",
        #         "parent_id": "bf97d1ed-41a4-47b1-b60e-bc91b1cd0952"
        #       }
        #     ]
        #   }
        def index
          directory = Directory.find(params[:id])
          authorize! :read, directory
          @resources = directory.documents
          render :'api/v1/documents/index'
        end
      end
    end
  end
end
