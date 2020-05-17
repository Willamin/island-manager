Rails.application.routes.draw do
  root 'pages#root'
  get '/about', to: 'pages#about'
  get '/flash-check', to: 'pages#flash_check'
  get '/card-check', to: 'pages#card_check'

  post '/login', to: 'auth#send_magic_link'
  get '/login/:token_id', to: 'auth#authenticate'

  get '/logout', to: 'auth#logout_page'
  post '/logout', to: 'auth#logout'

  post '/user', to: 'users#update'
  get '/user/me', to: 'users#me'
  get '/user/:id', to: 'users#profile'

  post '/turnips/current', to: 'users#update_current_turnips'
end
