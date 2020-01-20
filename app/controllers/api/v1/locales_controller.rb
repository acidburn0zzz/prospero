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
    # Anonymous users locales controller
    class LocalesController < Api::V1::BaseController
      skip_before_action :authenticate_user!
      skip_authorization_check

      rescue_from I18n::InvalidLocale, with: :server_error

      # Updates anonymous user locale
      #
      # Store locale in session cookie.
      #
      # PUT /api/v1/locale
      #
      # Parameters:
      #   locale - given locale
      #
      # Response: updated locale
      #   {
      #     "locale": "es"
      #   }
      def update
        locale = params.require(:locale)
        unless I18n.available_locales.include?(locale.to_sym)
          raise I18n::InvalidLocale, locale
        end

        session[:locale] = locale
        render json: { locale: locale }
      end
    end
  end
end
