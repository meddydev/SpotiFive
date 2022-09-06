class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :email
      t.string :name
      t.string :image_url
      t.integer :total_score, default: 0, null: false
      t.integer :num_games, default: 0, null: false
      t.string :auth_token
      t.string :refresh_token

      t.timestamps
    end
  end
end
