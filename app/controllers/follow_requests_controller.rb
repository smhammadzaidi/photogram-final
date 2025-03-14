class FollowRequestsController < ApplicationController
  def create
    @follow_request = FollowRequest.new(follow_request_params)
    @follow_request.sender = current_user
    
    if @follow_request.save
      redirect_to user_path(@follow_request.recipient), notice: "Follow request was successfully sent."
    else
      redirect_to user_path(@follow_request.recipient), alert: "Follow request could not be sent."
    end
  end
  
  def update
    @follow_request = FollowRequest.find(params[:id])
    
    if @follow_request.recipient == current_user
      if @follow_request.update(status: params[:status])
        redirect_to user_path(current_user), notice: "Follow request was successfully updated."
      else
        redirect_to user_path(current_user), alert: "Follow request could not be updated."
      end
    else
      redirect_to user_path(current_user), alert: "You are not authorized to perform this action."
    end
  end
  
  def destroy
    @follow_request = FollowRequest.find(params[:id])
    
    if @follow_request.sender == current_user || @follow_request.recipient == current_user
      @follow_request.destroy
      redirect_to user_path(current_user), notice: "Follow request was successfully destroyed."
    else
      redirect_to user_path(current_user), alert: "You are not authorized to perform this action."
    end
  end
  
  private
  
  def follow_request_params
    params.require(:follow_request).permit(:recipient_id)
  end
end 
