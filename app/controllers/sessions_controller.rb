class SessionsController < ApplicationController
  def index
    @client_id = Rails.application.credentials.spotifive[:client_id]
    @redirect_uri = sessions_login_url
  end

  def login
    code = params[:code]
    grant = Base64.strict_encode64("#{Rails.application.credentials.spotifive[:client_id]}:#{Rails.application.credentials.spotifive[:client_secret]}")
    token = RestClient.post("https://accounts.spotify.com/api/token", { 'grant_type': "authorization_code", 'code': code, "redirect_uri": sessions_login_url }, { 'Authorization': "Basic #{grant}" })
    token_json = JSON.parse(token)
    auth_token = token_json["access_token"]
    refresh_token = token_json["refresh_token"]
    user_data = RestClient.get("https://api.spotify.com/v1/me", { 'Authorization': "Bearer #{auth_token}", "Content-Type": "application/json", "Accept": "application/json" })
    user_data_json = JSON.parse(user_data)
    user_name = user_data_json["display_name"]
    user_email = user_data_json["email"]
    if user_data_json["images"][0]["url"] != nil
      user_img_url = user_data_json["images"][0]["url"]
    else
      user_img_url = "../../assets/stock_pp.jpeg"
    end
    user = User.find_by(email: user_email)
    if !user
      user = User.create(email: user_email, name: user_name, image_url: user_img_url, auth_token: auth_token, refresh_token: refresh_token)
    end
    session[:user] = user

    redirect_to "/home"
  end 


  def session_check
    print session[:user]
  end

  def logout
    reset_session
    # RestClient.get("https://accounts.spotify.com/logout")
    redirect_to "https://accounts.spotify.com/logout"
  end
end
