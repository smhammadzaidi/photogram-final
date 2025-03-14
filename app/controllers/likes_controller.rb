class LikesController < ApplicationController
  def create
    @like = Like.new(like_params)
    @like.fan = current_user
    
    if @like.save
      redirect_to @like.photo, notice: "Photo was successfully liked."
    else
      redirect_to @like.photo, alert: "Photo could not be liked."
    end
  end
  
  def destroy
    @like = Like.find(params[:id])
    
    if @like.fan == current_user
      photo = @like.photo
      @like.destroy
      redirect_to photo, notice: "Photo was successfully unliked."
    else
      redirect_to @like.photo, alert: "You are not authorized to perform this action."
    end
  end
  
  private
  
  def like_params
    params.require(:like).permit(:photo_id)
  end
end 
