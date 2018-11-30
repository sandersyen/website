Rails.application.routes.draw do
  if Rails.env.test?
    get 'login/simulate', to: 'logins#simulate', as: 'simulate_login'
  end

  post 'groups/:id/toggle_admin', to: 'groups#toggle_admin', as: 'toggle_admin'
  post 'groups/:id/create_post', to: 'groups#create_post', as: 'create_group_post'
  delete 'groups/:id/delete_post', to: 'groups#delete_post', as: 'delete_group_post'

  post 'groups/:id/join', to: 'groups#join_group', as: 'join_group'
  post 'groups/:id/leave', to: 'groups#leave_group', as: 'leave_group'
  post 'groups/:id/invite', to: 'groups#invite_member', as: 'invite_group_member'
  delete 'groups/:id/invite', to: 'groups#disinvite_member', as: 'disinvite_group_member'
  post 'groups/:id/accept_invite', to: 'groups#accept_invite', as: 'accept_group_invite'

  get 'events/:id/copy', to: 'events#copy', as: 'copy_event'
  get 'events/:id/rating/:rating', to: 'events#ratings', as: 'rate_event'

  resources :events
  resources :groups

  get 'notifications', to: 'notifications#index', as: 'notifications'
  delete 'notifications/:id', to: 'notifications#destroy', as: 'dismiss_notification'
  
  get '/help', to: 'pages#help', as: 'help'
  get '/about', to: 'pages#about', as: 'about'
  get '/terms', to: 'pages#terms', as: 'terms'
  get '/explore', to: 'pages#explore', as: 'explore'

  root 'pages#home', as: 'home'
  get 'login', to: 'logins#new', as: :login
  get 'login/create', to: 'logins#create', as: 'create_login'
  delete 'login/destroy', to: 'logins#destroy', as: 'logout'
end
