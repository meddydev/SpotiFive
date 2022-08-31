json.extract! user, :id, :email, :name, :image_url, :total_score, :num_games, :auth_token, :refresh_token, :created_at, :updated_at
json.url user_url(user, format: :json)
