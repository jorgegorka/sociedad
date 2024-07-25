Rails.application.routes.draw do
  get 'dashboard/index'
  namespace :admin do
    resources :accounts do
      resources :users
    end
  end
  resources :bookings
  resources :dashboard, only: :index, controller: 'dashboard'
  resources :sessions, only: %i[new create]
  resources :password_resets
  resources :users
  resources :resources
  resources :schedule_categories

  root to: 'dashboard#index'
end
