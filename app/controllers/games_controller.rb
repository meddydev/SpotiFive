class GamesController < ApplicationController
  before_action :set_game, only: %i[ show edit update destroy ]

  # GET /games or /games.json

  def guess_the_songs
    if session[:user]
      user = User.find_by(id: session[:id])
      refresh_tokens(user.refresh_token)
      user = User.find_by(id: session[:id])
      user_auth_token = user.auth_token
      data = RestClient.get("https://api.spotify.com/v1/playlists/0Hm1tCeFv45CJkNeIAtrfF", { 'Authorization': "Bearer #{user_auth_token}", "Content-Type": "application/json", "Accept": "application/json" })
      data = JSON.parse(data)
      artists = data["tracks"]["items"]
      artists.map! { |artist| { name: artist["track"]["album"]["artists"][0]["name"], id: artist["track"]["album"]["artists"][0]["id"] } }
      random_artist = artists.sample
      @artist = random_artist
      @artist_img_url = JSON.parse(RestClient.get("https://api.spotify.com/v1/artists/#{random_artist[:id]}", { 'Authorization': "Bearer #{user_auth_token}", "Content-Type": "application/json", "Accept": "application/json" }))["images"][0]["url"]
      top_tracks_data = JSON.parse(RestClient.get("https://api.spotify.com/v1/artists/#{random_artist[:id]}/top-tracks?market=GB", { 'Authorization': "Bearer #{user_auth_token}", "Content-Type": "application/json", "Accept": "application/json" }))["tracks"]
      @top_five_tracks = top_tracks_data[0, 5].map { |track| track["name"] }
    else
      redirect_to "/"
    end
  end

  def guess_the_artist
    user = session[:user]
    refresh_tokens(session[:user]["refresh_token"])
    user_auth_token = user["auth_token"]
    data = JSON.parse(RestClient.get("https://api.spotify.com/v1/playlists/0Hm1tCeFv45CJkNeIAtrfF", { 'Authorization': "Bearer #{user_auth_token}", "Content-Type": "application/json", "Accept": "application/json" }))
    artists = data["tracks"]["items"]
    artists.map! { |artist| { name: artist["track"]["album"]["artists"][0]["name"], id: artist["track"]["album"]["artists"][0]["id"] } }
    random_artist = artists.sample
    @artist = random_artist
    top_tracks_data = JSON.parse(RestClient.get("https://api.spotify.com/v1/artists/#{random_artist[:id]}/top-tracks?market=GB", { 'Authorization': "Bearer #{user_auth_token}", "Content-Type": "application/json", "Accept": "application/json" }))["tracks"]
    @top_five_tracks = top_tracks_data.sample(5).map { |track| track["name"].gsub(@artist[:name], "'THE ARTIST'S NAME'") }
  end



end
