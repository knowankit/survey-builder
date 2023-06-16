Rails.application.routes.draw do
  resources :question_options
  namespace :api do
    namespace :v1 do
      resources :sessions, only: [:create]
      resources :surveys
      resources :users
      resources :questions
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
