Rails.application.routes.draw do
  get '/scoreboard', to: 'scoreboard#index'
  root 'sessions#index'
  get 'sessions/login'
  get 'sessions/session_check'
  get 'logout', to: 'sessions#logout'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'game', to: 'games#index'
  get 'home', to: 'home#index'
  get 'result', to: 'result#index'
  resources :users
end
