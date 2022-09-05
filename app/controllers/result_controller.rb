SONG_GUESS_SIMILARITY_THRESHOLD = 50
class ResultController < ApplicationController
  skip_before_action :verify_authenticity_token  

  def index
    user_auth_token = session[:user]["auth_token"]
    artist_id = params[:artist_id]
    guesses = [params[:guess_1], params[:guess_2], params[:guess_3], params[:guess_4], params[:guess_5]]

    top_tracks_data = JSON.parse(RestClient.get("https://api.spotify.com/v1/artists/#{artist_id}/top-tracks?market=GB", { 'Authorization': "Bearer #{user_auth_token}", "Content-Type": "application/json", "Accept": "application/json" }))["tracks"]
    actuals = top_tracks_data[0,5].map{|track| track["name"]}
    
    @results =self.get_score(guesses, actuals)

    # @results = guess_formatted.zip(actual_formatted).map{|guess, actual| {guess: guess, actual: actual, score: self.get_score(guess,actual, actual_formatted,SONG_GUESS_SIMILARITY_THRESHOLD)}}
    @artist =JSON.parse(RestClient.get("https://api.spotify.com/v1/artists/#{artist_id}", { 'Authorization': "Bearer #{user_auth_token}", "Content-Type": "application/json", "Accept": "application/json" }))["name"]

  end 

  private


  def get_score(guesses, actuals)
    actuals_hash = Hash.new
    guesses_hash = Hash.new
    actuals.each_with_index do |actual, index|
      actuals_hash[index] = actual
    end 
    guesses.each_with_index do |guess, index|
      if actuals.any?{|actual| self.song_name_formatter(actual).similar(self.song_name_formatter(guess)) > SONG_GUESS_SIMILARITY_THRESHOLD}
        guesses_hash[index] = (actuals.select{|actual| self.song_name_formatter(actual).similar(self.song_name_formatter(guess)) > SONG_GUESS_SIMILARITY_THRESHOLD})[0]
      end 
    end 
    scores = Hash.new
    print "\nXXXXXX\n"
    print "EXACT MATCH"
    print("\nactual hash : ", actuals_hash)
    print("\nguess hash : ", guesses_hash)
    print "\nXXXXXX\n"
    actuals_hash.each do |key,value|
      if guesses_hash[key] == actuals_hash[key]
        scores[key] = 25
        guesses_hash.delete(key)
        actuals_hash.delete(key)
      else
        scores[key] = 0
      end
    end 
    print "\nXXXXXX\n"
    print "NEAR MATCH"
    print("actual hash : ", actuals_hash)
    print("\nguess hash : ", guesses_hash)
    print "\nXXXXXX\n"
    guesses_hash.each do |key,value|
      print("\nkey", key)
      print("\nvalue", value)
      if actuals_hash.value?(value)
        print("HAS VALUE")
        scores[key] = 10
        guesses_hash.delete(key)
        actuals_hash.delete(actuals_hash.key(value))
      end 
    end 

    print "\nXXXXXX\n"
    print actuals_hash
    print "\nXXXXXX\n"
    scores_array = []
    scores.each{ |index, score| scores_array.append({guess: guesses[index], actual: actuals[index], score: score})}
    return scores_array
  end 



  def song_name_formatter(song)
    if song.include?("remix")
      song_removed_hyphen = song
    else 
      song_removed_hyphen = song.sub /-.+/ ,""
    end 
    song_removed_brackets = song_removed_hyphen.sub /\(.+/ , ""
    return song_removed_brackets.strip.downcase

  end 

end
