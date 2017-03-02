Rails.application.routes.draw do
  root 'pages#index'

  devise_for :user
  match 'login', to: 'devise/sessions#new', via: :get
  match 'logout', to: 'devise/sessions#destroy', via: :delete
  match 'sign_up', to: 'devise/registrations#new', via: :get
  
  get 'dashboard', to: 'users#dashboard'

  resources :orders, except: [:new]
  resources :items
  resources :prices

  # get 'users/dashboard/:date/new', to: 'orders#new'
end
