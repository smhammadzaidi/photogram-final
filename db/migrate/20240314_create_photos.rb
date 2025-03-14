class CreatePhotos < ActiveRecord::Migration[7.0]
  def change
    create_table :photos do |t|
      t.text :caption
      t.string :image
      t.integer :comments_count, default: 0
      t.integer :likes_count, default: 0
      t.references :owner, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end 
