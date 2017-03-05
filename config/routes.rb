Rails.application.routes.draw do

  resources :audits
  #resources :flow_condition_groups
  resources :categories do
    resources :sub_categories
  end
  get '/sub_categories', to: 'sub_categories#list'

  resources :shops do
    get 'csv_import', on: :collection
    post 'csv_import', on: :collection
    resources :staffs, controller: 'shop_staffs'
  end
  resources :flow_grants
  resources :flows do
    post 'change_default', on: :member
    resources :flow_condition_groups
  end
  resources :jobs
  resources :requests do
    get 'executable', on: :collection
    get 'flow_not_defined', on: :collection
    put 'submit', on: :member
    get 'report', on: :member
    put 'report', on: :member
    get 'audit', on: :member
    get 'define_flow', on: :member
    put 'update_flow', on: :member
    put 'withdraw', on: :member
    resources :request_grants do
      get 'review', on: :member
    end
  end
  resources :request_audits
  resources :request_grants
  devise_for :users
  get 'home/index'
  root 'home#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
