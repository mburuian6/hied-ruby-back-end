Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "posts#index"

  resources :posts do
  end

  resources :bids, only: %i[create update destroy open_post_bids] do
    get :open_post_bids, on: :collection
    put :accept_bid, on: :collection
  end

  resources :rejected_bids, only: []

  resources :notifications, only:[] do

  end

end
