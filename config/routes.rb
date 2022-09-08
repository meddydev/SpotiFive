Rails.application.routes.draw do
  get '/scoreboard', to: 'scoreboard#index'
  root 'sessions#index'
  get 'sessions/login'
  get 'logout', to: 'sessions#logout'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'guess-songs', to: 'games#guess_the_songs'
  get 'home', to: 'home#index'
  get 'guess-songs/results', to: 'result#guess_the_songs_results'
  get 'guess-artist/results', to: 'result#guess_the_artist_results'
  get 'guess-artist', to: 'games#guess_the_artist'
  get 'test', to: 'home#test'
end
