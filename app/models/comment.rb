# == Schema Information
#
# Table name: comments
#
#  id         :bigint           not null, primary key
#  body       :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  author_id  :bigint
#  photo_id   :bigint
#
# Indexes
#
#  index_comments_on_author_id  (author_id)
#  index_comments_on_photo_id   (photo_id)
#
# Foreign Keys
#
#  fk_rails_...  (author_id => users.id)
#  fk_rails_...  (photo_id => photos.id)
#
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
