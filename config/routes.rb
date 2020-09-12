Rails.application.routes.draw do
  root to: 'home#index'

  namespace :api, { format: 'json' } do
    scope :v1 do
      mount_devise_token_auth_for 'User', at: 'auth', controllers: {
          registrations: 'api/v1/auth/registrations'
      }
    end
    namespace :v1 do

      resources :posts, only: %i[index show create update destroy] do
        get :likes, on: :collection
        member do
          get :categories
        end
      end

      resources :relationships, only: %i[create destroy]

      resources :users, only: %i[show update index] do
        get :current, on: :collection
        member do
          get :following, :followers, :follow_data, :posts
        end
      end

      resources :likes, only: %i[index create destroy] do
        member do
          get :posts, :users
        end
      end

      resources :categories, only: %i[index] do
        get :parents, on: :collection
        member do
          get :children, :post
        end
      end
    end
  end

end
