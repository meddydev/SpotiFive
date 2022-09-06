SONG_GUESS_SIMILARITY_THRESHOLD = 50
class ResultController < ApplicationController
  skip_before_action :verify_authenticity_token  

  def index
    user_auth_token = session[:user]["auth_token"]
    artist_id = params[:artist_id]
    guesses = [params[:guess_1], params[:guess_2], params[:guess_3], params[:guess_4], params[:guess_5]]
    guesses.map!{|input| self.input_formatter(input)}
    top_tracks_data = JSON.parse(RestClient.get("https://api.spotify.com/v1/artists/#{artist_id}/top-tracks?market=GB", { 'Authorization': "Bearer #{user_auth_token}", "Content-Type": "application/json", "Accept": "application/json" }))["tracks"]
    actuals = top_tracks_data[0,5].map{|track| track["name"]}
    
    guesses_hash = Hash.new
    actuals_hash = Hash.new
    guesses.zip(actuals).each_with_index do |guesses_and_actuals,index|
      guesses_hash[index] = guesses_and_actuals[0]
      actuals_hash[index] = guesses_and_actuals[1]
    end 
    @results =self.get_score(guesses, actuals, guesses_hash, actuals_hash)
    @artist =JSON.parse(RestClient.get("https://api.spotify.com/v1/artists/#{artist_id}", { 'Authorization': "Bearer #{user_auth_token}", "Content-Type": "application/json", "Accept": "application/json" }))["name"]

  end 

  private


  def get_score(guesses, actuals, guesses_hash, actuals_hash)
    scores = Hash.new
    self.get_perfect_match(guesses_hash,actuals_hash, scores)
    self.get_close_match(guesses_hash,actuals_hash, scores)
    scores_array = []
    scores.each{ |index, score| scores_array.append({guess: guesses[index], actual: actuals[index], score: score})}
    return scores_array
  end 

  def get_close_match(guesses_hash, actuals_hash, scores)
    actuals_hash.each do |actual_index, actual_song|
      scores_hash = Hash.new
      guesses_hash.each do |guess_index, guess_song|
        scores_hash[guess_index] = self.get_song_similarity(actual_song, guess_song)
      end 

      matching_song = scores_hash.filter{|index, score| score>SONG_GUESS_SIMILARITY_THRESHOLD }
      if matching_song.length!=0
        matching_song.select!{|k,v| v == matching_song.values.max }
        scores[(matching_song.keys[0])] = 10
        actuals_hash.delete(actual_index)
        guesses_hash.delete(matching_song.key(matching_song.values.max))
      end 

    end 

  end 


  def get_perfect_match(guesses_hash,actuals_hash, scores)
    actuals_hash.each do |index, song|
      if self.get_song_similarity(song, guesses_hash[index]) > SONG_GUESS_SIMILARITY_THRESHOLD 
        scores[index]=25 
        guesses_hash.delete(index)
        actuals_hash.delete(index)
      else 
        scores[index] = 0
      end 
    end 
  end 


  def song_name_formatter(song)
    song_downcase = song.downcase
    song_delatinised = ActiveSupport::Inflector.transliterate(song_downcase).to_s
    # if song_delatinised.include?("remix")
    #   song_formatted = song_delatinised.strip
    # else 
      song_removed_hyphen = song_delatinised.sub /-.+/ ,""
      song_removed_brackets = song_removed_hyphen.sub /\(.+/ , ""
      song_formatted = song_removed_brackets.strip
    # end 
    return song_formatted

  end 

  def input_formatter(input)
    if input==nil
      return ""
    end
    return input
  end 

  def get_song_similarity(song1, song2)
    song_similarity = self.song_name_formatter(song1).similar(self.song_name_formatter(song2))
    return song_similarity
  end



end


