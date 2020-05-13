Rails.application.routes.draw do
  root 'pages#root'
  get '/about', to: 'pages#about'
  get '/secret', to: 'pages#secret'

  post '/login', to: 'magic#accept_email'
  get '/login', to: 'magic#add_cookie'
  post '/logout', to: 'magic#remove_cookie'
end
