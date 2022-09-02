Rails.application.routes.draw do
  root 'sessions#index'
  get 'sessions/login'
  get 'sessions/session_check'
  get 'sessions/logout'
  resources :games
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :posts
  get 'home', to: 'home#index'
end
