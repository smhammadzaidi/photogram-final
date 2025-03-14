# == Schema Information
#
# Table name: follow_requests
#
#  id           :bigint           not null, primary key
#  status       :string           default("pending")
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  recipient_id :bigint
#  sender_id    :bigint
#
# Indexes
#
#  index_follow_requests_on_recipient_id                (recipient_id)
#  index_follow_requests_on_sender_id                   (sender_id)
#  index_follow_requests_on_sender_id_and_recipient_id  (sender_id,recipient_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (recipient_id => users.id)
#  fk_rails_...  (sender_id => users.id)
#
class FollowRequest < ApplicationRecord
  belongs_to :sender, class_name: "User"
  belongs_to :recipient, class_name: "User"
  
  validates :sender_id, uniqueness: { scope: :recipient_id, message: "already sent a follow request to this user" }
  validates :status, inclusion: { in: ["pending", "accepted", "rejected"] }
  
  # Callbacks
  before_validation :set_status_based_on_privacy, on: :create
  
  # Scopes
  scope :pending, -> { where(status: "pending") }
  scope :accepted, -> { where(status: "accepted") }
  scope :rejected, -> { where(status: "rejected") }
  
  private
  
  def set_status_based_on_privacy
    if recipient.private?
      self.status = "pending"
    else
      self.status = "accepted"
    end
  end
end 
