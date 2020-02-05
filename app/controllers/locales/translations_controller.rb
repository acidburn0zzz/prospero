# frozen_string_literal: true

# Prospero
#
# You should have received a copy of the license along with this program.
#
# Licensed under
# - GNU Affero General Public License V3
# - CeCILL Affero compliant

module Locales
  # Translations controller
  #
  # This controller renders translated messages to user interface.
  class TranslationsController < ApplicationController
    include TranslationsHelper

    # Show locale translations
    #
    # GET /locales/:locale/translation
    def show
      I18n.locale = params[:locale]
      @i18n = I18n
    end
  end
end
