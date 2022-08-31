json.extract! game, :id, :user_id, :artist_id, :artist_name, :score, :created_at, :updated_at
json.url game_url(game, format: :json)
