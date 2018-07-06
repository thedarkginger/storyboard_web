Rails.application.routes.draw do
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'

  devise_for :users

  namespace :api, defaults: { format: :json } do
    mount_devise_token_auth_for 'User', at: 'auth'
    resources :shows, only: [:create, :update, :show]
    resources :podcasts, only: [:create, :update, :show, :index]
  end

  get "welcomes/index", to: "welcomes#index"
  resources :shows
  resources :podcasts

  root "podcasts#index", to: "podcasts#index"
end
