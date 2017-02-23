Rails.application.routes.draw do
  root 'pages#index'
  devise_for :user
  match 'login', to: 'devise/sessions#new', via: :get
  match 'logout', to: 'devise/sessions#destroy', via: :delete
  match 'sign_up', to: 'devise/registrations#new', via: :get
end
