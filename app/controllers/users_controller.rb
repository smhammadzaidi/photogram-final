class UsersController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]
  
  def index
    @users = User.all
  end
  
  def show
    @user = User.find(params[:id])
    @photos = @user.photos.order(created_at: :desc)
    
    if @user.private? && @user != current_user
      unless @user.accepted_received_follow_requests.exists?(sender: current_user)
        redirect_to users_path, alert: "This account is private."
      end
    end
  end
  
  def feed
    @photos = current_user.feed_photos.order(created_at: :desc)
  end
  
  def discover
    @photos = current_user.discovery_photos.order(created_at: :desc)
  end
  
  def liked
    @photos = Photo.joins(:likes).where(likes: { fan: current_user }).order(created_at: :desc)
  end
end 
