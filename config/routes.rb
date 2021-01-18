Rails.application.routes.draw do
  devise_for :users
  root to: 'customers#index'
  resources :customers do
    resources :orders, only: [:new, :create, :edit, :update, :destroy]
  end
end
