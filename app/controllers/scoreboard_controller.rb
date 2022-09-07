class ScoreboardController < ApplicationController
  def index
    if session[:id]
      user = User.find_by(id: session[:id])
      @users = User.all
      users_dict = []
      @users.each do | user_object | 
        one_user = Hash.new
        one_user[:id] = user_object.id
        one_user[:name] = user_object.name
        one_user[:total_score] = user_object.total_score
        one_user[:num_games] = user_object.num_games
        if user_object.num_games > 0
          one_user[:av_score] = user_object.total_score / user_object.num_games
        else 
          one_user[:av_score] = 0
        end
        users_dict << one_user
      end
      @users_sorted_total_score = users_dict.sort_by {|user| -user[:total_score]}
      @logged_in_user_id = user.id
    else
      redirect_to "/"
    end
  end
end
