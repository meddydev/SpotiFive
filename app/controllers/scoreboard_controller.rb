class ScoreboardController < ApplicationController
  def index
    if session[:user]
      @users = User.all
    else 
      redirect_to "/"
    end
  end
end
