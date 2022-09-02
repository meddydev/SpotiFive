Rails.application.routes.draw do
  get '/scoreboard', to: 'scoreboard#index'
  root 'sessions#index'
  get 'sessions/login'
  get 'sessions/session_check'
  get 'sessions/logout'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get 'home', to: 'home#index'
end
