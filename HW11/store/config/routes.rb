Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  devise_for :users
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end

  resources :products
  resources :categories
  resources :orders, only: %i[create new index show]

  resources :line_items, only: %i[create update destroy]
  post 'line_items/:id/increase_quantity', to: 'line_items#increase_quantity', as: 'line_item_increase'
  post 'line_items/:id/decrease_quantity', to: 'line_items#decrease_quantity', as: 'line_item_decrease'

  get '/carts/:id', to: 'carts#show', as: 'cart'

  root 'products#index'
end
