Rails.application.routes.draw do
  namespace :admin do
    resources :accounts do
      resources :users
    end
  end
  resources :sessions, only: %i[new create]
  resources :password_resets
  resources :users
  resources :resources
end
