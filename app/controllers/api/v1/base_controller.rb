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
    # Base Application error
    #
    # All business-logic errors in the application must raise this exception
    # with an explicit error message.
    class ApplicationError < StandardError
      attr_accessor :message

      def initialize(message)
        self.message = message
      end
    end

    # Base APIv1 controller
    #
    # This is the superclass of all APIv1 controllers.
    class BaseController < Api::BaseController
      # Endpoints that don't need authentication must explicitly skip this
      # filter.
      #
      # See https://guides.rubyonrails.org/action_controller_overview.html#filters
      before_action :authenticate_user!, except: :not_found

      # See https://guides.rubyonrails.org/action_controller_overview.html#rescue-from
      rescue_from ApplicationError,
                  with: :application_error
      rescue_from ActiveRecord::RecordInvalid,
                  with: :record_invalid
      rescue_from ActiveRecord::RecordNotFound,
                  with: :not_found

      respond_to :json

      private

      def application_error(exception)
        @error = exception.message
        render :error, status: :bad_request
      end

      def record_invalid(exception)
        @error = exception.record.errors
        render :error, status: :bad_request
      end
    end
  end
end
