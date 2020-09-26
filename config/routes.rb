Rails.application.routes.draw do
  root to: 'home#index'

  namespace :api, { format: 'json' } do
    scope :v1 do
      mount_devise_token_auth_for 'User', at: 'auth', controllers: {
          registrations: 'api/v1/auth/registrations'
      }
    end
    namespace :v1 do

      resources :users, only: %i[show update index] do
        get :current, on: :collection
        member do
          get :following, :followers, :follow_data, :posts, :list_folders
        end
      end

      resources :relationships, only: %i[create destroy]

      resources :posts, only: %i[index show create update destroy] do
        get :likes, on: :collection
        member do
          get :categories
        end
      end

      resources :likes, only: %i[index create destroy] do
        member do
          get :posts, :users
        end
      end

      resources :lists, only: %i[index show create destroy]

      resources :list_folders, only: %i[index show create update destroy] do
        member do
          get :posts
        end
      end

      resources :categories, only: %i[index] do
        get :parents, on: :collection
        member do
          get :children, :search
        end
      end

      namespace :admin do
        resources :users, only: %i[index show destroy]
      end
    end
  end

  resources :admin, only: %i[index]

end
