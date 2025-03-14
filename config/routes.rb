Rails.application.routes.draw do
  devise_for :users
  
  # Root route
  root "photos#index"
  
  # Username-based routes
  get '/users/:username', to: 'users#show', as: 'username'
  get '/users/:username/feed', to: 'users#feed', as: 'user_feed'
  
  # Resources
  resources :photos
  resources :comments, only: [:create, :destroy]
  resources :likes, only: [:create, :destroy]
  resources :follow_requests, only: [:create, :update, :destroy]
  
  # User routes
  resources :users, only: [:index, :show] do
    collection do
      get :feed
      get :discover
      get :liked
    end
  end
end
