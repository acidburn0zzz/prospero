# frozen_string_literal: true

# Prospero
#
# You should have received a copy of the license along with this program.
#
# Licensed under
# - GNU Affero General Public License V3
# - CeCILL Affero compliant

# Application backend routes definitions
#
# See https://guides.rubyonrails.org/routing.html
Rails.application.routes.draw do
  root to: "home#index"
end
