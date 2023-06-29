Rails.application.routes.draw do
  resources :refresh_tokens

  namespace :api do
    namespace :v1 do
      resources :sessions, only: [:create]

      resources :surveys do
        resources :questions do
          resources :question_options
        end
      end

      resources :users
      resources :answers
      resources :responses

      resources :refresh_tokens, only: %i[create destroy]
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
