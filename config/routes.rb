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

  resources :users, only: %i[index show] do
    namespace :requests, as: :request do
      resources :confirmed, only: :index
      resources :unconfirmed, only: :index
      resources :archived, only: :index
      resources :declined, only: :index
    end
  end

  resources :requests, except: :destroy do
    resources :decisions, only: %i[new create]
  end
  namespace :requests, as: :request do
    resources :confirmed, only: :update
    resources :declined, only: :update
    resources :archived, only: :update
  end

  resources :decisions, only: %i[index show]
  namespace :decisions, as: :decision do
    resources :accepted, only: :update
    resources :partly_accepted, only: :update
    resources :rejected, only: :update
  end
end
