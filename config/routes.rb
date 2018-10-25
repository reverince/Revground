Rails.application.routes.draw do
  get 'users/new'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'pages#home'
  get '/home', to: 'pages#home'
  get '/about', to: 'pages#about'
  get '/signup', to: 'users#new'
end
