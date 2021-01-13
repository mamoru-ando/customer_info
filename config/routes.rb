Rails.application.routes.draw do
  devise_for :users
  root to: 'customers#index'
  
end
