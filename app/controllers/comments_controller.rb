class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]
  before_action :ensure_author, only: [:edit, :update, :destroy]
  
  def create
    @comment = Comment.new(comment_params)
    @comment.author = current_user
    
    if @comment.save
      redirect_to @comment.photo, notice: "Comment created successfully."
    else
      redirect_to @comment.photo, alert: "Comment could not be created."
    end
  end
  
  def destroy
    photo = @comment.photo
    @comment.destroy
    redirect_to photo, notice: "Comment deleted successfully."
  end
  
  private
  
  def set_comment
    @comment = Comment.find(params[:id])
  end
  
  def ensure_author
    unless @comment.author == current_user
      redirect_to @comment.photo, alert: "You are not authorized to perform this action."
    end
  end
  
  def comment_params
    params.require(:comment).permit(:body, :photo_id, :author_id)
  end
end 
