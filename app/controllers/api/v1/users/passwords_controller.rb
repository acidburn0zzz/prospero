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
      # Passwords controller
      #
      # This controller handles endpoints for password recovery.
      #
      # This is a JSON-based API implementation of Devise::PasswordsController
      #
      # See https://github.com/plataformatec/devise/blob/v4.7.1/app/controllers/devise/passwords_controller.rb
      class PasswordsController < Api::V1::BaseController
        skip_before_action :authenticate_user!
        skip_authorization_check

        # Sends reset password instructions by e-mail
        #
        # POST /api/v1/users/passwords
        #
        # Parameters:
        #  user[email] - User's e-mail address
        #
        # Response: acknowledge
        #   {
        #     "response": "ok"
        #   }
        def create
          User.send_reset_password_instructions(user_params)
          render :ok
        end

        # Resets user's password
        #
        # PUT /api/v1/users/passwords
        #
        # Parameters:
        #   token          - the password reset token sent by e-mail
        #   user[password] - new password
        #
        # Response: acknowledge
        #   {
        #     "response": "ok"
        #   }
        def update
          @resource = User.reset_password_by_token(
            user_params.merge(
              reset_password_token: params.require(:token),
              password_confirmation: user_params[:password]
            )
          )
          if @resource.errors.present?
            raise ActiveRecord::RecordInvalid, @resource
          end

          render :ok
        end

        private

        def user_params
          params.require(:user)
                .permit(:email,
                        :password)
        end
      end
    end
  end
end
