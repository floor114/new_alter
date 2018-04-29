Rails.application.routes.draw do
  root to: 'pages#home'

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    passwords: 'users/passwords',
    confirmations: 'users/confirmations'
  }

  namespace :pages do
    get :about
  end

  resources :users, only: :show

  resources :requests, except: :destroy do
    resources :decisions, only: [:new, :create]
  end
  namespace :requests, as: :request do
    resources :confirmed, only: :update
    resources :declined, only: :update
    resources :archived, only: :update
  end

  resources :decisions, only: [:index, :show]
end
