# frozen_string_literal: true

# Prospero
#
# You should have received a copy of the license along with this program.
#
# Licensed under
# - GNU Affero General Public License V3
# - CeCILL Affero compliant

# Pages controller
#
# This controller renders static pages.
class PagesController < ApplicationController
  before_action :set_locale, except: :root

  rescue_from I18n::InvalidLocale, with: :not_found

  # Redirects to default locale's home page
  def root
    redirect_to "/#{I18n.default_locale}"
  end

  private

  def set_locale
    I18n.locale = params[:locale]
  end
end
