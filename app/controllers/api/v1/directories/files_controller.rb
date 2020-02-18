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
      # Files controller
      #
      # This controller handles the endpoints for management of files inside a
      # given directory in Prospero library.
      class FilesController < Api::V1::BaseController
        # List files of a directory
        #
        # GET /api/v1/directories/:id/files
        #
        # Response: list of files of the directory
        #   {
        #     "files": [
        #       {
        #         "id": "a0b45f5e-a3cf-4597-ae46-625cea4dd356",
        #         "name": "Social movements",
        #         "type": "Directory"
        #       },
        #       {
        #         "id": "928cab06-a278-4831-9aea-e1b1b516db30",
        #         "name": "Id ea aliquid excepturi",
        #         "type": "Document"
        #       }
        #     ]
        #   }
        def index
          directory = Directory.find(params[:id])
          authorize! :read, directory
          @resources = directory.files
        end
      end
    end
  end
end
