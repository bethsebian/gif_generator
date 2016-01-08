Rails.application.routes.draw do

  # namespace :admin do
  #   resources :gifs, only: [:new]
  # end

  resources :gifs, only: [:index]
  resources :users, only: [:new, :create]

end
