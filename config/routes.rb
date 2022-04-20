Rails.application.routes.draw do
  use_doorkeeper do
    skip_controllers :authorizations, :applications, :authorized_applications
  end
  # devise_for :users

  resources :users, only: %i[create]

  # Defines the root path route ("/")
  root "posts#index"

  resources :posts do
  end

  resources :post_links, only: :post do
  end

  get '/post_link' => 'post_links#post'

  resources :bids, only: %i[create update destroy open_post_bids] do
    get :open_post_bids, on: :collection
    put :accept_bid, on: :collection
  end

  resources :rejected_bids, only: []

  resources :accepted_bids, only: []

  resources :notifications, only: %i[all_notifications] do
    get :all_notifications, on: :collection
  end

  mount ActionCable.server => '/cable'

end
