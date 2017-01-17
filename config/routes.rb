Rails.application.routes.draw do

  resources :users, only: [:index, :show] do
    get 'csv_import', on: :collection
    post 'csv_import', on: :collection
  end

  resources :shops do
    get 'csv_import', on: :collection
    post 'csv_import', on: :collection
  end
  resources :flow_grants
  resources :flows
  resources :jobs
  resources :requests do
    get 'executable', on: :collection
    get 'flow_not_defined', on: :collection
    put 'submit', on: :member
    get 'report', on: :member
    put 'report', on: :member
    get 'define_flow', on: :member
    put 'update_flow', on: :member
    put 'withdraw', on: :member
    resources :request_grants do
      get 'review', on: :member
    end
  end
  resources :request_grants
  devise_for :users
  get 'home/index'
  root 'home#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
