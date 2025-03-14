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
  
  # From the ERD, we can see the FollowRequest model has these attributes:
  # id (integer, PK)
  # created_at (datetime)
  # recipient_id (integer, FK)
  # sender_id (integer, FK)
  # status (string)
  # updated_at (datetime)
  
  private
  
  def set_status_based_on_privacy
    if recipient.private?
      self.status = "pending"
    else
      self.status = "accepted"
    end
  end
end 
