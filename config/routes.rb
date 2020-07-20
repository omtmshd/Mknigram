Rails.application.routes.draw do

  root to: "posts#index"

  devise_for :users, :controllers => {
    :registrations => 'users/registrations',
    :sessions => 'users/sessions'
  }
  devise_scope :user do
    get "sign_up", :to => "users/registrations#new"
    get "sign_in", :to => "users/sessions#new"
    delete "sign_out", :to => "users/sessions#destroy"
  end
  resources :users, only: [:show, :edit, :update, :index] do
    member do
      get :following, :followers
    end
  end
  resources :posts
  resources :categories
end
