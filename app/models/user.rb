# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  comments_count         :integer          default(0)
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  likes_count            :integer          default(0)
#  private                :boolean          default(FALSE)
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  username               :string           not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_username              (username) UNIQUE
#
class User < ApplicationRecord
  # Include default devise modules
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  # Associations
  has_many :photos, foreign_key: :owner_id, dependent: :destroy
  has_many :likes, foreign_key: :fan_id, dependent: :destroy
  has_many :comments, foreign_key: :author_id, dependent: :destroy
  has_many :sent_follow_requests, class_name: "FollowRequest", foreign_key: "sender_id", dependent: :destroy
  has_many :received_follow_requests, class_name: "FollowRequest", foreign_key: "recipient_id", dependent: :destroy
  
  # Validations
  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  
  # Helper methods for follow functionality
  def accepted_sent_follow_requests
    sent_follow_requests.where(status: "accepted")
  end
  
  def accepted_received_follow_requests
    received_follow_requests.where(status: "accepted")
  end
  
  def pending_received_follow_requests
    received_follow_requests.where(status: "pending")
  end
  
  def following
    User.where(id: accepted_sent_follow_requests.pluck(:recipient_id))
  end
  
  def followers
    User.where(id: accepted_received_follow_requests.pluck(:sender_id))
  end
  
  def feed_photos
    Photo.where(owner_id: following.pluck(:id))
  end
  
  def discovery_photos
    Photo.where(id: Like.where(fan_id: following.pluck(:id)).pluck(:photo_id)).distinct
  end
end 
