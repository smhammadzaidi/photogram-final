class Photo < ApplicationRecord
  # Active Storage for image uploads
  has_one_attached :image
  
  # Associations
  belongs_to :owner, class_name: "User", foreign_key: :owner_id
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :fans, through: :likes, source: :fan
  
  # Validations
  validates :image, presence: true
  
  # Scopes
  scope :public_photos, -> { joins(:owner).where(users: { private: false }) }
  
  # Helper methods
  def liked_by?(user)
    likes.exists?(fan: user)
  end
  
  def like_by(user)
    likes.find_by(fan: user)
  end
  
  # From the ERD, we can see the Photo model has these attributes:
  # id (integer, PK)
  # caption (text)
  # comments_count (integer)
  # created_at (datetime)
  # image (string)
  # likes_count (integer)
  # owner_id (integer, FK)
  # updated_at (datetime)
end 
