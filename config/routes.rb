Rails.application.routes.draw do
  # post 'orders/new' => 'orders#create'
  # get 'orders/new'
  devise_for :users
  root to: 'customers#index'
  resources :customers do
    resources :orders, only: [:new, :create]
  end
end
