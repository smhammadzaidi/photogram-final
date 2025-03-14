class Like < ApplicationRecord
  belongs_to :fan, class_name: "User", foreign_key: :fan_id
  belongs_to :photo, counter_cache: true
  
  validates :fan_id, uniqueness: { scope: :photo_id, message: "has already liked this photo" }
  
  # From the ERD, we can see the Like model has these attributes:
  # id (integer, PK)
  # created_at (datetime)
  # fan_id (integer, FK)
  # photo_id (integer, FK)
  # updated_at (datetime)
end 
