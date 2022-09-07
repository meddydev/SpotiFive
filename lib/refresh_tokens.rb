def refresh_tokens(refresh_token)
  grant = Base64.strict_encode64("#{Rails.application.credentials.spotifive[:client_id]}:#{Rails.application.credentials.spotifive[:client_secret]}")

  response = RestClient.post("https://accounts.spotify.com/api/token", { 'grant_type': "refresh_token", "refresh_token": session[:user]["refresh_token"] }, { 'Authorization': "Basic #{grant}" })
  json_response = JSON.parse(response)
  auth_token = json_response["access_token"]
  if json_response["refresh_token"]
    refresh_token = json_response["refresh_token"]
    User.find(session[:user]["id"]).update_column(:refresh_token, refresh_token)
  end
  User.find(session[:user]["id"]).update_column(:auth_token, auth_token)
end