class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :email
      t.string :name
      t.string :image_url
      t.integer :total_score
      t.integer :num_games
      t.string :auth_token
      t.string :refresh_token

      t.timestamps
    end
  end
end
