class LikesController < ApplicationController
  def create
    @like = Like.new(like_params)
    @like.fan = current_user
    
    if @like.save
      redirect_to @like.photo, notice: "Like created successfully."
    else
      redirect_to @like.photo, alert: "Photo could not be liked."
    end
  end
  
  def destroy
    @like = Like.find(params[:id])
    
    if @like.fan == current_user
      photo = @like.photo
      @like.destroy
      redirect_to photo, notice: "Like deleted successfully."
    else
      redirect_to @like.photo, alert: "You are not authorized to perform this action."
    end
  end
  
  private
  
  def like_params
    params.require(:like).permit(:photo_id, :fan_id)
  end
end 
