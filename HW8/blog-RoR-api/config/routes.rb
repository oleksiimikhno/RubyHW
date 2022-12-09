Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :articles do
        get :comments, on: :member
        get :published, on: :member
        get :unpublished, on: :member
        get 'add-tags', to: 'articles#add_tags', on: :member
      end

      resources :comments do
        get :switch, to: 'comments#switch_status', on: :member
        get :published, on: :collection
        get :unpublished, on: :collection
      end
      resources :tags
      resources :likes, only: %i[create destroy]
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  # get "/api/v1/articles", to: "articles#index"
end
