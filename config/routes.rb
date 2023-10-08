# frozen_string_literal: true
require 'sidekiq/web'

Rails.application.routes.draw do
  resources :refresh_tokens

  if Rails.env.development? || Rails.env.staging?
    mount Sidekiq::Web => '/sidekiq'
  end

  namespace :api do
    namespace :v1 do
      devise_for :users, path: '', path_names: {
        sign_in: 'login',
        sign_out: 'logout',
        registration: 'signup'
      },
      controllers: {
        sessions: 'api/v1/users/sessions',
        registrations: 'api/v1/users/registrations'
      }

      get 'surveys/permalink_validation', to: 'surveys#permalink_validation'
      get 'responses', to: 'responses#get_all_responses'

      resources :surveys do
        resources :questions do
          resources :question_options
        end

        get '/published', to: 'surveys#show_published_survey'

        put '/publish', to: 'surveys#publish'
        put '/unpublish', to: 'surveys#unpublish'

        resources :answers, only: [:create]
        resources :responses
      end

      # get 'users/me', to: 'users#me'
      # get 'users/logout', to: 'users#logout'
      # resources :users

      resources :refresh_tokens, only: %i[create destroy]
    end
  end

  get '/heartbeat', to: 'heartbeat#index'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
