Rails.application.routes.draw do
  root to: 'pages#home'

  namespace :pages do
    get :about
  end
end
