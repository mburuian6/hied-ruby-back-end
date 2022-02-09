Rails.application.routes.draw do
  devise_for :users

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "posts#index"

  resources :posts do
  end

  resources :post_links do
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

end
