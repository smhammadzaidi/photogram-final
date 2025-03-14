class CreateFollowRequests < ActiveRecord::Migration[7.0]
  def change
    create_table :follow_requests do |t|
      t.references :sender, foreign_key: { to_table: :users }
      t.references :recipient, foreign_key: { to_table: :users }
      t.string :status, default: "pending"

      t.timestamps
    end
    
    add_index :follow_requests, [:sender_id, :recipient_id], unique: true
  end
end 
