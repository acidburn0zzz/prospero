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
    # Authentication controller
    #
    # This controllers handles authentication endpoints.
    #
    # A JSON-based API implementation of Devise::SessionsController
    #
    # See https://github.com/plataformatec/devise/blob/v4.7.1/app/controllers/devise/sessions_controller.rb
    class AuthController < Api::V1::BaseController
      skip_before_action :authenticate_user!, only: :create
      prepend_before_action :allow_params_authentication!, only: :create

      # Sign in
      #
      # Creates a session cookie that identifies the user on the next requests.
      #
      # POST /api/v1/auth
      #
      # Parameters:
      #   user[email]    - E-mail address
      #   user[password] - Password
      #
      # Response: signed in user
      #   {
      #     "user": {
      #       "id": "b74ec2d0-ec55-4c6a-91bd-c4c669aa34f5",
      #       "email": "email@example.net"
      #     }
      #   }
      def create
        @resource = warden.authenticate!(scope: :user)
        render :'api/v1/users/show'
      end

      # Sign out
      #
      # Deletes the session cookie.
      #
      # DELETE /api/v1/auth
      #
      # Response: signed out user
      #   {
      #     "user": {
      #       "id": "b74ec2d0-ec55-4c6a-91bd-c4c669aa34f5",
      #       "email": "email@example.net"
      #     }
      #   }
      def destroy
        @resource = current_user
        sign_out(@resource)
        render :'api/v1/users/show'
      end
    end
  end
end
