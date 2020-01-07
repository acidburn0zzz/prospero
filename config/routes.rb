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
  # See https://guides.rubyonrails.org/routing.html#using-root
  root to: 'application#index'

  # Route for sample pages
  get '/sample/:id', to: 'application#index'

  # See https://www.rubydoc.info/github/plataformatec/devise/master/ActionDispatch/Routing/Mapper%3Adevise_for
  devise_for :users, skip: :all

  get '/user/confirmation', to: 'application#index', as: :user_confirmation
  get '/password/edit',     to: 'application#index', as: :edit_user_password

  # Error routes
  match '404', to: 'application#not_found',    via: :all
  match '500', to: 'application#server_error', via: :all

  # Routes for testing errors
  if Rails.env.development? || Rails.env.test?
    match '/error/404', to: 'application#not_found',    via: :all
    match '/error/500', to: 'application#server_error', via: :all
  end

  # See https://guides.rubyonrails.org/routing.html#controller-namespaces-and-routing
  namespace :api do
    # APIv1 Routes
    namespace :v1, defaults: { format: 'json' } do
      resource :auth,  only: %i[create destroy], controller: :auth
      resource :users, only: %i[create update destroy]
      namespace :users do
        resource :confirmations, only: %i[create update]
        resource :passwords,     only: %i[create update]
      end
    end
  end
end
