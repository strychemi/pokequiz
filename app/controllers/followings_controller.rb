class FollowingsController < ApplicationController

  def create
    @follow = Following.new(follower: current_user, followed: User.find(params[:id]))
    if @follow.save
      flash[:success] = "Followed #{User.find(params[:id]).profile.full_name}"
      redirect_to users_path
    else
      flash[:error] = "Could not follow" +
          @follow.errors.full_messages.join(', ')
      redirect_to request.referrer
    end
  end

  def destroy
    @follow = Following.find(params[:id])
    if @follow.destroy
      flash[:success] = "You are no longer following this user"
      redirect_to users_path
    else
      flash[:error] = "Unable to remove following"
      redirect_to request.referrer
    end
  end

  private

  def follow_params
    params.permit(:id)
  end
end
