class CreateLikes < ActiveRecord::Migration[7.0]
  def change
    create_table :likes do |t|
      t.references :fan, foreign_key: { to_table: :users }
      t.references :photo, foreign_key: true

      t.timestamps
    end
    
    add_index :likes, [:fan_id, :photo_id], unique: true
  end
end 
