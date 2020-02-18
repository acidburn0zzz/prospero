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
    # Users registrations controller
    #
    # This controller implements the endpoints for creating, updating, and
    # deleting users.
    #
    # This is a JSON-based API implementation of Devise::RegistrationsController
    #
    # See https://github.com/plataformatec/devise/blob/v4.7.1/app/controllers/devise/registrations_controller.rb
    class UsersController < Api::V1::BaseController
      skip_before_action :authenticate_user!, only: :create

      # List users
      #
      # GET /api/v1/users
      #
      # Reponse: the list of users
      #   {
      #     "users": [
      #       {
      #         "id": "b74ec2d0-ec55-4c6a-91bd-c4c669aa34f5",
      #         "full_name": "Ulrike Meinhof"
      #       },
      #       {
      #         "id": "68d35a64-6e49-4b78-8e8d-dbb0a60bb9d4",
      #         "full_name": "Baden Powell"
      #       }
      #     ]
      #   }
      def index
        authorize! :list, User
        @resources = User.all
      end

      # Creates a new user
      #
      # POST /api/v1/users
      #
      # Parameters:
      #   user[email]     - New user's e-mail address
      #   user[full_name] - New user's full name
      #   user[password]  - New user's password
      #
      # Response: the newly created user
      #   {
      #     "user": {
      #       "id": "b74ec2d0-ec55-4c6a-91bd-c4c669aa34f5",
      #       "email": "email@example.net",
      #       "full_name": "Ulrike Meinhof"
      #     }
      #   }
      def create
        @resource = User.new(user_params)
        authorize! :create, @resource
        @resource.save!
        render :show
      end

      # Shows a user
      #
      # GET /api/v1/users/:id
      #
      # Response: the requested user
      #   {
      #     "user": {
      #       "id": "b74ec2d0-ec55-4c6a-91bd-c4c669aa34f5",
      #       "email": "email@example.net",
      #       "full_name": "Ulrike Meinhof"
      #     }
      #   }
      def show
        @resource = User.find(params[:id])
        authorize! :read, @resource
      end

      # Updates user
      #
      # If the e-mail address is updated, a confirmation token will be sent to
      # the new address. You need to confirm the new address for the changing to
      # be effective.
      #
      # PUT /api/v1/users/:id
      #
      # Parameters:
      #   user[email]     - New e-mail address
      #   user[full_name] - New full name
      #   user[password]  - New password
      #
      # Response: the updated user
      #   {
      #     "user": {
      #       "id": "b74ec2d0-ec55-4c6a-91bd-c4c669aa34f5",
      #       "email": "email@example.net",
      #       "full_name": "Marielle Franco"
      #     }
      #   }
      def update
        @resource = User.find(params[:id])
        authorize! :update, @resource
        @resource.update!(user_params)
        render :show
      end

      # Deletes user
      #
      # DELETE /api/v1/users/:id
      #
      # Parameters:
      #   user[password] - password confirmation
      #
      # Response: the deleted user
      #   {
      #     "user": {
      #       "id": "b74ec2d0-ec55-4c6a-91bd-c4c669aa34f5",
      #       "email": "email@example.net",
      #       "full_name": "Alexandra David-Neel"
      #     }
      #   }
      def destroy
        @resource = User.find(params[:id])
        authorize! :destroy, @resource
        unless @resource.valid_password?(user_params[:password])
          raise ApplicationError, translate('errors.password_missmatch')
        end

        @resource.destroy!
        render :show
      end

      private

      def user_params
        params.require(:user)
              .permit(:email,
                      :password,
                      :full_name)
      end
    end
  end
end
