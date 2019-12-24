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
      # Users confirmations controller
      #
      # This controllers handles the endpoints for confirming user's email
      # addresses.
      #
      # A JSON-based API implementation of Devise::ConfirmationsController
      #
      # See https://github.com/plataformatec/devise/blob/v4.7.1/app/controllers/devise/confirmations_controller.rb
      class ConfirmationsController < Api::V1::BaseController
        skip_before_action :authenticate_user!

        # Re-sends e-mail address confirmation token
        #
        # This endpoint don't give clients any feedback about the presence of
        # the e-mail address in the database.
        #
        # POST /api/v1/users/confirmations
        #
        # Parameters:
        #   user[email] - User's e-mail address
        #
        # Response: acknowledge
        #   {
        #     "response": "ok"
        #   }
        def create
          @resource = User.send_confirmation_instructions(user_params)
          render :ok
        end

        # Confirms e-mail address
        #
        # PUT /api/v1/users/confirmations
        #
        # Parameters:
        #   token - the confirmation token sent by e-mail
        #
        # Response: the user with confirmed e-mail address
        #   {
        #     "user": {
        #       "id": "b74ec2d0-ec55-4c6a-91bd-c4c669aa34f5",
        #       "email": "new.email@example.net"
        #     }
        #   }
        def update
          @resource = User.confirm_by_token(params[:token])
          if @resource.errors.present?
            raise ActiveRecord::RecordInvalid, @resource
          end

          render :'/api/v1/users/show'
        end

        private

        def user_params
          params.require(:user)
                .permit(:email)
        end
      end
    end
  end
end
