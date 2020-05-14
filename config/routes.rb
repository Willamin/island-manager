Rails.application.routes.draw do
  root 'pages#root'
  get '/about', to: 'pages#about'
  get '/secret', to: 'pages#secret'

  post '/login', to: 'auth#accept_email'
  get '/login/:token_id', to: 'auth#add_cookie'

  get '/logout', to: 'auth#logout'
  post '/logout', to: 'auth#remove_cookie'

  post '/user', to: 'users#update'
  get '/user/me', to: 'users#me'
  get '/user/:id', to: 'users#profile'
end
