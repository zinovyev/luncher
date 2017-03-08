Rails.application.routes.draw do
  root 'pages#index'

  devise_for :user
  match 'login', to: 'devise/sessions#new', via: :get
  match 'logout', to: 'devise/sessions#destroy', via: :delete
  match 'sign_up', to: 'devise/registrations#new', via: :get
  
  get 'dashboard', to: 'users#dashboard'
  get 'dashboard/:date/new', to: 'orders#new', as: :new_order
  post 'dashboard/:date/select_price',
    to: 'orders#select_price',
    as: :orders_select_price

  resources :orders, except: [:new]
  resources :items
  resources :prices

  namespace :api do
    namespace :v1 do
      resources :orders, only: [:index]
      resources :users, lnly: [:index, :show]
    end
  end
end
