class HomeController < ApplicationController
  def index
    if session[:id]
      user = User.find_by(id: session[:id])
      @name = user.name
      @profile_picture_url = user.image_url
      user_id = user.id
      user_games = Game.where(user_id: user_id)
      @recent_games = user_games.slice(0, 5)
    else
      redirect_to "/"
    end
  end
end
