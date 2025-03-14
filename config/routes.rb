Rails.application.routes.draw do
  devise_for :users
  
  # Root route
  root "photos#index"
  
  # Username-based routes - these need to be before resources :users
  get '/users/:username', to: 'users#show', as: 'username_user'
  get '/users/:username/feed', to: 'users#feed', as: 'username_feed'
  get '/users/:username/liked_photos', to: 'users#liked', as: 'username_liked_photos'
  get '/users/:username/discover', to: 'users#discover', as: 'username_discover'
  
  # Resources
  resources :photos
  resources :comments, only: [:create, :destroy]
  resources :likes, only: [:create, :destroy]
  resources :follow_requests, only: [:create, :update, :destroy]
  
  # User routes
  resources :users, only: [:index, :show] do
    member do
      get :feed
      get :liked, path: 'liked_photos'
      get :discover
    end
    collection do
      get :feed
      get :discover
      get :liked
    end
  end
end
