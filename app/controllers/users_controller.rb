class UsersController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]
  
  def index
    @users = User.all
  end
  
  def show
    find_user
    
    # Return early if @user is nil (the find_user method will handle the redirect)
    return unless @user
    
    @photos = @user.photos.order(created_at: :desc)
    
    # We'll let the view handle showing/hiding content for private accounts
    # instead of redirecting
  end
  
  def feed
    if params[:username]
      @user = User.find_by(username: params[:username])
      if @user.nil?
        redirect_to users_path, alert: "User not found."
        return
      end
      @photos = @user.feed_photos.order(created_at: :desc)
    elsif params[:id]
      @user = User.find(params[:id])
      if @user.nil?
        redirect_to users_path, alert: "User not found."
        return
      end
      @photos = @user.feed_photos.order(created_at: :desc)
    else
      authenticate_user!
      @photos = current_user.feed_photos.order(created_at: :desc)
    end
    render :feed
  end
  
  def discover
    authenticate_user!
    @photos = current_user.discovery_photos.order(created_at: :desc)
  end
  
  def liked
    authenticate_user!
    @photos = Photo.joins(:likes).where(likes: { fan: current_user }).order(created_at: :desc)
  end
  
  private
  
  def find_user
    if params[:username]
      @user = User.find_by(username: params[:username])
    elsif params[:id]
      @user = User.find(params[:id])
    end
    
    if @user.nil?
      redirect_to users_path, alert: "User not found."
      return
    end
  end
end 
