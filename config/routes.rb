Rails.application.routes.draw do
  post 'auth/login', to: 'authentication#authenticate'
  post '/signup', to: 'users#create'

  resources :users
  resources :houses
  resources :favorites, only: %i[index create destroy]
end
