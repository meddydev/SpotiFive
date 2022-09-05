class HomeController < ApplicationController
  def index
    if session[:user]
      @name = session[:user]["name"]
      @profile_picture_url = session[:user]["image_url"]
      user_id = session[:user]["id"]
      user_games = Game.where(user_id: user_id)
      @recent_games = user_games.slice(0, 5)
    else
      redirect_to "/"
    end
  end
end
