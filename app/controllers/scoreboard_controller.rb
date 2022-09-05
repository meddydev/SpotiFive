class ScoreboardController < ApplicationController
  def index
    if session[:user]
      @users = User.all
      @users = User.all
      users_dict = []
      @users.each do | user_object | 
        one_user = Hash.new
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
      puts users_dict
      users_sorted_total_score = users_dict.sort_by {|user| -user[:total_score]}
      puts "START", users_sorted_total_score
  end
end
