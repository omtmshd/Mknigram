Rails.application.routes.draw do

  root to: 'home#index'

  namespace :api, { format: 'json' } do
    namespace :v1 do
      resources :likes, only: %i[index create destroy]
      resources :posts, only: %i[index show create update destroy]
      resources :relationships, only: %i[create destroy]
      resources :users, only: %i[show update index] do
        get :current, on: :collection
        member do
          get :following
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

  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }

  devise_scope :user do
    get 'sign_up', to: 'users/registrations#new'
    get 'sign_in', to: 'users/sessions#new'
    delete 'sign_out', to: 'users/sessions#destroy'
  end

end
