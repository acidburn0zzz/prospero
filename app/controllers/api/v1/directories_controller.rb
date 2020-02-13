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
    # Directories controller
    #
    # This controller handles the endpoints for directories management in
    # Prospero library.
    class DirectoriesController < Api::V1::BaseController
      # List directories
      #
      # GET /api/v1/directories
      #
      # Reponse: the list of directories
      #   {
      #     "directories": [
      #       {
      #         "id": "18c673f0-b9fa-4e90-a622-e8a13e58ea67",
      #         "name": "Social movements",
      #         "parent_id": null
      #       },
      #       {
      #         "id": "93f3feba-d66f-4193-b78b-39615b31d978",
      #         "name": "Yellow jackets",
      #         "parent_id": "18c673f0-b9fa-4e90-a622-e8a13e58ea6"
      #       }
      #     ]
      #   }
      def index
        authorize! :list, Directory
        @resources = Directory.all
      end

      # Create directory
      #
      # POST /api/v1/directories
      #
      # Parameters:
      #   directory[name]      - New directory's name
      #   directory[parent_id] - New directory's parent ID
      #
      # Reponse: the newly created directory
      #   {
      #     "directory":{
      #       "id": "9dbcdf61-666c-4393-bdcf-0de20b4e8f51",
      #       "name": "Energy transition",
      #       "parent_id": "8348add8-1595-48c6-aae4-8a5634f653d5"
      #     }
      #   }
      def create
        @resource = Directory.new(directory_params)
        authorize! :create, @resource
        @resource.save!
        render :show
      end

      # Update directory
      #
      # PUT /api/v1/directories/:id
      #
      # Parameters:
      #   directory[name]      - New name
      #   directory[parent_id] - New parent ID
      #
      # Reponse: the updated directory
      #   {
      #     "directory":{
      #       "id": "9dbcdf61-666c-4393-bdcf-0de20b4e8f51",
      #       "name": "Energy transition in Germany",
      #       "parent_id": "5fa989bd-f173-4007-836e-e1c6b035cad0"
      #     }
      #   }
      def update
        @resource = Directory.find(params[:id])
        authorize! :update, @resource
        @resource.update!(directory_params)
        render :show
      end

      # Delete directory
      #
      # DELETE /api/v1/directories/:id
      #
      # Reponse: the deleted directory
      #   {
      #     "directory":{
      #       "id": "9dbcdf61-666c-4393-bdcf-0de20b4e8f51",
      #       "name": "Energy transition in Germany",
      #       "parent_id": "5fa989bd-f173-4007-836e-e1c6b035cad0"
      #     }
      #   }
      def destroy
        @resource = Directory.find(params[:id])
        authorize! :destroy, @resource
        @resource.destroy!
        render :show
      end

      private

      def directory_params
        params.require(:directory)
              .permit(:name,
                      :parent_id)
      end
    end
  end
end
