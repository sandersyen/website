Rails.application.routes.draw do
  resources :events
  resources :groups
  get 'pages/help', as: 'help'
  get 'pages/about', as: 'about'
  get 'pages/terms', as: 'terms'

  get 'sessions/sign_in', as: 'sign_in'
  get 'sessions/sign_out', as: 'sign_out'

  root 'pages#home', as: 'home'
end
