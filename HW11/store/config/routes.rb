Rails.application.routes.draw do
  
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  devise_for :users
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end

  resources :products
  resources :categories
  # resources :carts

  get '/carts/:id', to: 'carts#show', as: 'cart'
  post 'line_items', to: 'line_items#create'

  # get "carts#show", as: "cart"
  #  get 'carts/show', as: 'cart'
  
  # get 'carts/show'

  root 'products#index'
end
