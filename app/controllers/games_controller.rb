class GamesController < ApplicationController
  before_action :set_game, only: %i[ show edit update destroy ]

  # GET /games or /games.json
  def index
    user = session[:user]
    user_auth_token = user["auth_token"]
    data = RestClient.get("https://api.spotify.com/v1/playlists/0Hm1tCeFv45CJkNeIAtrfF", { 'Authorization': "Bearer #{user_auth_token}", "Content-Type": "application/json", "Accept": "application/json" })

    data = JSON.parse(data)
    artists = data["tracks"]["items"]
    artists.map! { |artist| { name: artist["track"]["album"]["artists"][0]["name"], id: artist["track"]["album"]["artists"][0]["id"] } }
    random_artist = artists.sample
    @artist = random_artist


    top_tracks_data = JSON.parse(RestClient.get("https://api.spotify.com/v1/artists/#{random_artist[:id]}/top-tracks?market=GB", { 'Authorization': "Bearer #{user_auth_token}", "Content-Type": "application/json", "Accept": "application/json" }))["tracks"]
    @top_five_tracks = top_tracks_data[0,5].map{|track| track["name"]}
  end

end 
