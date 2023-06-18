Rails.application.routes.draw do
  resources :answers
  resources :responses
  resources :question_options
  namespace :api do
    namespace :v1 do
      resources :sessions, only: [:create]
      resources :surveys
        resources :questions
      resources :users
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
