Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }
  root to: 'customers#index'
  resources :customers do
    resources :orders, only: [:new, :create, :edit, :update, :destroy]
    collection do
      get 'search'
    end
  end
  resources :users, only: [:edit, :update]
end
