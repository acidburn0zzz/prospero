# frozen_string_literal: true

# Prospero
#
# You should have received a copy of the license along with this program.
#
# Licensed under
# - GNU Affero General Public License V3
# - CeCILL Affero compliant

# Base controller class
#
# This is the superclass of all controllers.
#
# See https://guides.rubyonrails.org/action_controller_overview.html
class ApplicationController < ActionController::Base
  skip_before_action :verify_authenticity_token,
                     only: %i[not_found server_error]

  # HTTP status 404
  #
  # Render error response for resources not found.
  def not_found
    respond_to do |format|
      format.html do
        render :not_found, status: :not_found
      end
      format.json do
        @error = translate('errors.messages.not_found')
        render :error, status: :not_found
      end
    end
  end

  # HTTP status 500
  #
  # Render error response for internal server errors.
  def server_error
    respond_to do |format|
      format.html do
        render :server_error, status: :internal_server_error
      end
      format.json do
        @error = translate('errors.messages.server_error')
        render :error, status: :internal_server_error
      end
    end
  end
end
