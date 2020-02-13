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
  root to: 'pages#root'

  get '/app',                 to: 'pages#app', as: :app
  get '/app/directories',     to: 'pages#app', as: :app_directories
  get '/app/directories/:id', to: 'pages#app', as: :app_directory

  get '/:locale', to: 'pages#home', as: :home

  get '/:locale/users/sign_in',
      to: 'pages#devise',
      as: :sign_in
  get '/:locale/users/sign_up',
      to: 'pages#devise',
      as: :sign_up
  get '/:locale/users/confirmations/new',
      to: 'pages#devise',
      as: :new_user_confirmation
  get '/:locale/users/confirmations/edit',
      to: 'pages#devise',
      as: :edit_user_confirmation
  get '/:locale/users/passwords/new',
      to: 'pages#devise',
      as: :new_user_password
  get '/:locale/users/passwords/edit',
      to: 'pages#devise',
      as: :edit_user_password

  # See https://www.rubydoc.info/github/plataformatec/devise/master/ActionDispatch/Routing/Mapper%3Adevise_for
  devise_for :users, skip: :all, failure_app: Devise::JsonFailureApp

  # Error routes
  match '404', to: 'application#not_found',    via: :all
  match '500', to: 'application#server_error', via: :all

  # Routes for testing errors
  if Rails.env.development? || Rails.env.test?
    match '/error/404', to: 'application#not_found',    via: :all
    match '/error/500', to: 'application#server_error', via: :all
  end

  resources :locales, param: :locale, only: [] do
    member do
      get :translation, to: 'locales/translations#show'
    end
  end

  # See https://guides.rubyonrails.org/routing.html#controller-namespaces-and-routing
  namespace :api do
    # APIv1 Routes
    namespace :v1, defaults: { format: 'json' } do
      resource :auth,   only: %i[create destroy], controller: :auth
      resources :directories, only: %i[index create update destroy] do
        member do
          resources :documents,
                    only: :index,
                    controller: 'directories/documents'
        end
      end
      resources :documents, only: %i[create show update destroy]
      resource :locale, only: :update
      namespace :users do
        resource :confirmations, only: %i[create update]
        resource :passwords,     only: %i[create update]
      end
      resources :users, only: %i[index create show update destroy] do
        member do
          resource :preference,
                   only: %i[show update],
                   controller: 'users/preferences'
        end
      end
    end
  end
end
