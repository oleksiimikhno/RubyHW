Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  devise_for :users
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end

  resources :products, only: %i[index show create update destroy]
  resources :categories, only: %i[show]
  resources :orders, only: %i[index show create new update]
  resources :line_items, only: %i[create update destroy]

  patch 'orders/:id/switch', to: 'orders#switch_status', as: 'switch'
  get '/carts/:id', to: 'carts#show', as: 'cart'

  root 'products#index'
end
