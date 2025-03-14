class CreateComments < ActiveRecord::Migration[7.0]
  def change
    create_table :comments do |t|
      t.text :body
      t.references :author, foreign_key: { to_table: :users }
      t.references :photo, foreign_key: true

      t.timestamps
    end
  end
end 
