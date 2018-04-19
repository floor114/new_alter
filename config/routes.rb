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
end
