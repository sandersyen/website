Rails.application.routes.draw do
  get 'pages/home'
  get 'pages/help'
  get 'pages/about'
  get 'pages/terms'

  get 'sessions/sign_in'
  get 'sessions/sign_out'

  resources :groups

  root 'pages#home'
end
