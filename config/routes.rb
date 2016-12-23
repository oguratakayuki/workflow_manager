Rails.application.routes.draw do
  resources :flow_grants
  resources :flows
  resources :jobs
  resources :requests, except: [:edit] do
    get 'grant', on: :member
    get 'report', on: :member
    get 'reject', on: :member
    resources :request_grants do
      get 'review', on: :member
    end
  end
  devise_for :users
  get 'home/index'
  root 'home#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
