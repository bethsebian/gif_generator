Rails.application.routes.draw do

  namespace :admin do
    resources :gifs, only: [:new, :create]
  end

  resources :gifs, only: [:index, :show]
  resources :users, only: [:new, :create, :show]

  get '/login', to: "sessions#new"
  post '/login', to: 'sessions#create' 

end
