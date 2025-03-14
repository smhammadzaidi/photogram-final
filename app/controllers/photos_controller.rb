class PhotosController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]
  before_action :set_photo, only: [:show, :edit, :update, :destroy]
  before_action :ensure_owner, only: [:edit, :update, :destroy]
  
  def index
    @photos = Photo.public_photos.order(created_at: :desc)
  end
  
  def show
    @comments = @photo.comments.order(created_at: :desc)
    @comment = Comment.new
  end
  
  def new
    @photo = Photo.new
  end
  
  def create
    @photo = current_user.photos.new(photo_params)
    
    if @photo.save
      redirect_to @photo, notice: "Photo was successfully created."
    else
      render :new
    end
  end
  
  def edit
  end
  
  def update
    if @photo.update(photo_params)
      redirect_to @photo, notice: "Photo was successfully updated."
    else
      render :edit
    end
  end
  
  def destroy
    @photo.destroy
    redirect_to photos_url, notice: "Photo was successfully destroyed."
  end
  
  private
  
  def set_photo
    @photo = Photo.find(params[:id])
  end
  
  def ensure_owner
    unless @photo.owner == current_user
      redirect_to photos_url, alert: "You are not authorized to perform this action."
    end
  end
  
  def photo_params
    params.require(:photo).permit(:caption, :image)
  end
end 
