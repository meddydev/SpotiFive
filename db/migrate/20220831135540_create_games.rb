class CreateGames < ActiveRecord::Migration[6.1]
  def change
    create_table :games do |t|
      t.integer :user_id
      t.string :artist_id
      t.string :artist_name
      t.integer :score

      t.timestamps
    end
    add_index :games, :user_id
  end
end
