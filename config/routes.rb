Rails.application.routes.draw do
  root 'pages#root'
  get '/about', to: 'pages#about'
end
