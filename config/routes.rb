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

  get '/app',           to: 'pages#react', as: :app
  get '/app/users',     to: 'pages#react', as: :app_users
  get '/app/users/:id', to: 'pages#react', as: :app_user

  get '/:locale', to: 'pages#home', as: :home

  get '/:locale/users/sign_in',
      to: 'pages#react',
      as: :sign_in
  get '/:locale/users/sign_up',
      to: 'pages#react',
      as: :sign_up
  get '/:locale/users/confirmations/new',
      to: 'pages#react',
      as: :new_user_confirmation
  get '/:locale/users/confirmations/edit',
      to: 'pages#react',
      as: :edit_user_confirmation
  get '/:locale/users/passwords/new',
      to: 'pages#react',
      as: :new_user_password
  get '/:locale/users/passwords/edit',
      to: 'pages#react',
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
      resource :locale, only: :update
      namespace :users do
        resource :confirmations, only: %i[create update]
        resource :passwords,     only: %i[create update]
      end
      resources :users, only: %i[index create show update destroy] do
        member do
          get :preference, to: 'users/preferences#show'
          put :preference, to: 'users/preferences#update'
        end
      end
    end
  end
end
