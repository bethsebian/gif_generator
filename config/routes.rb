Rails.application.routes.draw do

  namespace :admin do
    resources :gifs, only: [:new, :create]
  end

  resources :gifs, only: [:index, :show, :destroy]
  resources :users, only: [:new, :create, :show]

  get '/login', to: "sessions#new"
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  root to: 'gifs#index'

end
