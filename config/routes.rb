# frozen_string_literal: true

Rails.application.routes.draw do
  resources :refresh_tokens

  namespace :api do
    namespace :v1 do
      resources :sessions, only: [:create]

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


      get 'users/me', to: 'users#me'
      get 'users/logout', to: 'users#logout'
      resources :users

      resources :refresh_tokens, only: %i[create destroy]
    end
  end

  get '/heartbeat', to: 'heartbeat#index'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
