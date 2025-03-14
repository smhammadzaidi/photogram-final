# == Schema Information
#
# Table name: photos
#
#  id             :bigint           not null, primary key
#  caption        :text
#  comments_count :integer          default(0)
#  image          :string
#  likes_count    :integer          default(0)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  owner_id       :bigint
#
# Indexes
#
#  index_photos_on_owner_id  (owner_id)
#
# Foreign Keys
#
#  fk_rails_...  (owner_id => users.id)
#
class Photo < ApplicationRecord
  # CarrierWave for image uploads
  require 'carrierwave/orm/activerecord'
  mount_uploader :image, ImageUploader
  
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
    return false unless user
    likes.exists?(fan: user)
  end
  
  def like_by(user)
    return nil unless user
    likes.find_by(fan: user)
  end
end 
