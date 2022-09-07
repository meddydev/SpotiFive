SONG_GUESS_SIMILARITY_THRESHOLD = 50
CONFETTI_THRESHOLD = 20

class ResultController < ApplicationController


  def guess_the_songs_results()
    if session[:id]
      user = User.find_by(id: session[:id])
      refresh_tokens(user.refresh_token)
      user = User.find_by(id: session[:id])
      user_auth_token = user.auth_token
      artist_id = params[:artist_id]
      guesses = [params[:guess_1], params[:guess_2], params[:guess_3], params[:guess_4], params[:guess_5]]
      guesses.map! { |input| self.input_formatter(input) }
      top_tracks_data = JSON.parse(RestClient.get("https://api.spotify.com/v1/artists/#{artist_id}/top-tracks?market=GB", { 'Authorization': "Bearer #{user_auth_token}", "Content-Type": "application/json", "Accept": "application/json" }))["tracks"]
      actuals = top_tracks_data[0, 5].map { |track| track["name"] }

      guesses_hash = Hash.new
      actuals_hash = Hash.new
      guesses.zip(actuals).each_with_index do |guesses_and_actuals, index|
        guesses_hash[index] = guesses_and_actuals[0]
        actuals_hash[index] = guesses_and_actuals[1]
      end
      @results = self.gts_get_results(guesses, actuals, guesses_hash, actuals_hash)
      artist_data = JSON.parse(RestClient.get("https://api.spotify.com/v1/artists/#{artist_id}", { 'Authorization': "Bearer #{user_auth_token}", "Content-Type": "application/json", "Accept": "application/json" }))
      @artist_name = artist_data["name"]
      @artist_img_url = artist_data["images"][0]["url"]
      score = self.gts_get_score(@results)
      self.gts_create_game(session[:user]["id"], artist_id, @artist_name, score)
      @confetti = score > CONFETTI_THRESHOLD
    else
      redirect_to "/"
    end
  end


  def guess_the_artist_results()
    if session[:id]
      user = User.find_by(id: session[:id])
      refresh_tokens(user.refresh_token)
      user = User.find_by(id: session[:id])
      user_auth_token = user.auth_token
      @guess = params[:guess]
      artist_id = params[:artist_id]
      artist_data = JSON.parse(RestClient.get("https://api.spotify.com/v1/artists/#{artist_id}", { 'Authorization': "Bearer #{user_auth_token}", "Content-Type": "application/json", "Accept": "application/json" }))
      @artist_name = artist_data["name"]
      @artist_img_url = artist_data["images"][0]["url"]
      @score = self.get_text_similarity(@artist_name, @guess) >50 ? 25 : 0
      self.gta_create_game(session[:user]["id"], artist_id, @artist_name, @score)
      @confetti = @score > CONFETTI_THRESHOLD
    else
      redirect_to "/"
    end
  end 
  private

  def gts_create_game(user_id, artist_id, artist_name, score)
    last_game = Game.where("user_id = ? AND artist_id = ? AND hard = 'true'", user_id, artist_id)
    if (last_game.length == 0 || (Time.zone.now - last_game.last[:created_at]).seconds / 1.months > 1)
      Game.create(user_id: session[:user]["id"], artist_id: artist_id, artist_name: artist_name, score: score, hard: true)
      user = User.find_by(id: session[:user]["id"])
      user["total_score_hard"] += score
      user["num_games_hard"] += 1
      user.save()
    end
  end

  def gta_create_game(user_id, artist_id, artist_name, score)
    last_game = Game.where("user_id = ? AND artist_id = ? AND hard = 'false'", user_id, artist_id)
    if (last_game.length == 0 || (Time.zone.now - last_game.last[:created_at]).seconds / 1.months > 1)
      Game.create(user_id: session[:user]["id"], artist_id: artist_id, artist_name: artist_name, score: score, hard: false)
      user = User.find_by(id: session[:user]["id"])
      user["total_score_easy"] += score
      user["num_games_easy"] += 1
      user.save()
    end
  end

  def gts_get_score(results)
    score = 0
    results.each { |result| score += result[:score] }
    return score
  end

  def gts_get_results(guesses, actuals, guesses_hash, actuals_hash)
    scores = Hash.new
    self.gts_get_perfect_match(guesses_hash, actuals_hash, scores)
    self.gts_get_close_match(guesses_hash, actuals_hash, scores)
    scores_array = []
    scores.each { |index, score| scores_array.append({ guess: guesses[index], actual: actuals[index], score: score }) }
    return scores_array
  end

  def gts_get_close_match(guesses_hash, actuals_hash, scores)
    actuals_hash.each do |actual_index, actual_song|
      scores_hash = Hash.new
      guesses_hash.each do |guess_index, guess_song|
        scores_hash[guess_index] = self.get_text_similarity(actual_song, guess_song)
      end

      matching_song = scores_hash.filter { |index, score| score > SONG_GUESS_SIMILARITY_THRESHOLD }
      if matching_song.length != 0
        matching_song.select! { |k, v| v == matching_song.values.max }
        scores[(matching_song.keys[0])] = 10
        actuals_hash.delete(actual_index)
        guesses_hash.delete(matching_song.key(matching_song.values.max))
      end
    end
  end

  def gts_get_perfect_match(guesses_hash, actuals_hash, scores)
    actuals_hash.each do |index, song|
      if self.get_text_similarity(song, guesses_hash[index]) > SONG_GUESS_SIMILARITY_THRESHOLD
        scores[index] = 25
        guesses_hash.delete(index)
        actuals_hash.delete(index)
      else
        scores[index] = 0
      end
    end
  end

  def text_formatter(text)
    text_downcase = text.downcase
    text_delatinised = ActiveSupport::Inflector.transliterate(text_downcase).to_s
    text_removed_hyphen = text_delatinised.sub /-.+/, ""
    text_removed_brackets = text_removed_hyphen.sub /\(.+/, ""
    text_formatted = text_removed_brackets.strip
    return text_formatted
  end

  def input_formatter(input)
    if input == nil
      return ""
    end
    return input
  end

  def get_text_similarity(text1, text2)
    text_similarity = self.text_formatter(text1).similar(self.text_formatter(text2))
    return text_similarity
  end
end
