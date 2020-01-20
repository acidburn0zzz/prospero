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
    module Users
      # Users preferences controller
      #
      # This controller handles endpoints for users preferences such as locale.
      class PreferencesController < Api::V1::BaseController
        # Show user's preference
        #
        # GET /api/v1/users/:id/preference
        #
        # Response: user's preference
        #   {
        #     "locale": "de"
        #   }
        def show
          @resource = User.find(params[:id]).preference
          authorize! :read, @resource
        end

        # Update user's preference
        #
        # PUT /api/v1/users/:id/preference
        #
        # Parameters:
        #   preference[locale] - New locale
        #
        # Response: updated user's preference
        #   {
        #     "locale": "es"
        #   }
        def update
          @resource = User.find(params[:id]).preference
          authorize! :update, @resource
          @resource.update!(preference_params)
          render :show
        end

        private

        def preference_params
          params.require(:preference)
                .permit(:locale)
        end
      end
    end
  end
end
