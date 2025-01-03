Rails.application.routes.draw do
  get "dashboard/index"
  namespace :admin do
    resources :accounts do
      resources :users
    end
  end
  resources :bookings do
    collection do
      post :check
    end
  end
  resources :sessions, only: %i[new create destroy]
  resources :password_resets
  resources :users
  resources :resources
  resources :schedule_categories
  resources :calendar, only: %i[index]
  resources :calendar_events, only: %i[index]

  root to: "calendar#index"
  get "/login", to: "sessions#new"
end
