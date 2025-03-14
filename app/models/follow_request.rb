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
