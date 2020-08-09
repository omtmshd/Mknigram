Rails.application.routes.draw do

  root to: 'home#index'

  namespace :api, { format: 'json' } do
    namespace :v1 do
      resources :likes, only: %i[index create destroy]
      resources :posts, only: %i[index show create update destroy]
    end
  end

  get 'categories_post(/:id)' => 'categories#post_index'
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }

  devise_scope :user do
    get 'sign_up', to: 'users/registrations#new'
    get 'sign_in', to: 'users/sessions#new'
    delete 'sign_out', to: 'users/sessions#destroy'
  end

  resources :users, only: %i[show edit update index] do
    member do
      get :following, :followers
    end
  end

  resources :relationships, only: %i[create destroy]
end
