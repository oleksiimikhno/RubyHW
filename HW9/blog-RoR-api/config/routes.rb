Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'

  namespace :api do
    namespace :v1 do
      resources :articles do
        member do
          get :comments
          get :published
          get :unpublished
          post 'add-tag', to: 'articles#add_tag'
        end
      end

      resources :comments do
        collection do
          get :published
          get :unpublished
        end
      end

      resources :tags
      resources :authors
      resources :likes, only: %i[create destroy]
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  # get "/api/v1/articles", to: "articles#index"
end
