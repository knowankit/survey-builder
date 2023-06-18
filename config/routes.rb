Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      resources :sessions, only: [:create]
      resources :surveys do
        resources :questions
      end
      resources :users
      resources :answers
      resources :responses
      resources :question_options
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
