Rails.application.routes.draw do
  if Rails.env.test?
    get 'login/simulate', to: 'logins#simulate', as: 'simulate_login'
  end

  resources :events
  resources :groups
  get 'pages/help', as: 'help'
  get 'pages/about', as: 'about'
  get 'pages/terms', as: 'terms'

  get 'pages/explore', as: 'explore'

  get 'sessions/sign_in', as: 'sign_in'
  get 'sessions/sign_out', as: 'sign_out'

  root 'pages#home', as: 'home'
  get 'login', to: 'logins#new', as: :login
  get 'login/create', to: 'logins#create', as: :create_login
  delete 'login/destroy', to: 'logins#destroy', as: :logout
end
