Rails.application.routes.draw do

  namespace :admin do
    resources :gifs, only: [:new, :create]
  end

  resources :gifs, only: [:index]
  resources :users, only: [:new, :create, :show]

end
