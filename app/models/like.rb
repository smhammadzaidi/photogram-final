# == Schema Information
#
# Table name: likes
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  fan_id     :bigint
#  photo_id   :bigint
#
# Indexes
#
#  index_likes_on_fan_id               (fan_id)
#  index_likes_on_fan_id_and_photo_id  (fan_id,photo_id) UNIQUE
#  index_likes_on_photo_id             (photo_id)
#
# Foreign Keys
#
#  fk_rails_...  (fan_id => users.id)
#  fk_rails_...  (photo_id => photos.id)
#
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
