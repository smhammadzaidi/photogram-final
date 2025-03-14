class Comment < ApplicationRecord
  belongs_to :author, class_name: "User", foreign_key: :author_id
  belongs_to :photo, counter_cache: true
  
  validates :body, presence: true
  
  # From the ERD, we can see the Comment model has these attributes:
  # id (integer, PK)
  # author_id (integer, FK)
  # body (text)
  # created_at (datetime)
  # photo_id (integer, FK)
  # updated_at (datetime)
end 
