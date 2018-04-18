Rails.application.routes.draw do
  root to: 'pages#home'

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    passwords: 'users/passwords',
    confirmations: 'users/confirmations'
  }

  namespace :users, as: :user do
    resources :registrations_steps
  end

  namespace :pages do
    get :about
  end
end
