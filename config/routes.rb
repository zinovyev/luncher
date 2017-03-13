Rails.application.routes.draw do
  root 'pages#index'

  devise_for :user, controllers: { registrations: 'registrations' }
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

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :orders, only: [:index]
      resources :users, only: [:show]
    end
  end

  namespace :admin do
    resources :users, except: [:new, :show]
    resources :items do
      get :autocomplete_item_title, :on => :collection
    end
    resources :orders
    resources :organizations do
      resources :prices, except: [:index, :show, :new, :create, :edit]
    end
  end
  post '/admin/organizations/:organization_id/prices/:date',
    to: 'admin/prices#create',
    as: :admin_organization_prices
  get '/admin/organizations/:organization_id/prices/:date/new',
    to: 'admin/prices#new',
    as: :new_admin_organization_price
end
