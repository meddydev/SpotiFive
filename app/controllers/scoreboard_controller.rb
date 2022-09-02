class ScoreboardController < ApplicationController
  def index
    if session[:user]
      @users = User.all
    else 
      render status: 403
    end
  end
end
