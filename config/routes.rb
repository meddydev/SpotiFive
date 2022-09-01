Rails.application.routes.draw do
  get 'scoreboard/index'
  root 'login#index'
  get 'login/callback'
  resources :games
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :posts
end
