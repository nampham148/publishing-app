Rails.application.routes.draw do
  devise_for :users, :controllers => { omniauth_callbacks: "users/omniauth_callbacks", registrations: "users/registrations" }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'posts#index'
  resources :posts, except: :new do
    get 'pending', on: :collection
    post 'approve', on: :member
  end
  resources :users, only: [:show, :index]
  resources :vote_relationships, only: [:create, :destroy]
end
