class ScoreboardController < ApplicationController
  def index
    if session[:id]
      user = User.find_by(id: session[:id])
      @users = User.all
      @games = Game.all

      @easy_games = Hash.new(0)
      @games.each do | games_object |
        if games_object.score == 25 && games_object.hard == false
          @easy_games[games_object.user_id] += 1
        end
      end
      puts "EASY GAMES ARRAY:", @easy_games
      all_games = []
      @users.each do | user_object | 
        one_user = Hash.new
        one_user[:id] = user_object.id
        one_user[:name] = user_object.name
        one_user[:total_score_easy] = user_object.total_score_easy
        one_user[:num_games_easy] = user_object.num_games_easy
        one_user[:total_score_hard] = user_object.total_score_hard
        one_user[:num_games_hard] = user_object.num_games_hard
        if user_object.num_games_hard > 0
          one_user[:av_score] = user_object.total_score_hard / user_object.num_games_hard
        else 
          one_user[:av_score] = 0
        end

        if @easy_games[one_user[:id].to_i] != nil
          one_user[:easy_game_wins] = @easy_games[one_user[:id].to_i]
          one_user[:win_percentage] = one_user[:num_games_easy].to_f==0 ? 0 : ((one_user[:easy_game_wins].to_f/one_user[:num_games_easy].to_f)*100).to_i
          puts "easy:", @easy_games[one_user[:id].to_i]
        else
          one_user[:easy_game_wins] = 0
        end

        all_games << one_user
        puts "ALL GAMES:", all_games
      end

      @games_sorted_total_scores = all_games.sort_by {|user| -user[:av_score]}
      @games_sorted_percentage = all_games.sort_by {|user| -user[:win_percentage]}
      @logged_in_user_id = user.id
    else
      redirect_to "/"
    end
  end
end
