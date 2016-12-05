Rails.application.routes.draw do
  resources :flow_grants
  resources :flows
  resources :jobs
  resources :requests
  devise_for :users
  get 'home/index'
  root 'home#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
