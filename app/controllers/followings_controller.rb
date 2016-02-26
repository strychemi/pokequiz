class FollowingsController < ApplicationController
  before_action :require_login, only: [:create, :destroy]

  def create
    followed = User.find_by_id(params[:id])
    if followed
      following = Following.new(follower_id: current_user.id, followed_id: followed.id)
      if following.save
        flash[:success] = "Followed #{followed.profile.full_name}"
        redirect_to :back
      else
        flash[:danger] = "Could not follow" +
          following.errors.full_messages.join(', ')
        redirect_to request.referrer
      end
    else
      flash[:danger] = "User doesn't exist!"
      redirect_to users_path
    end
  end

  def destroy
    followed = User.find_by_id(params[:id])
    if followed
      following = Following.find_by(follower_id: current_user.id, followed_id: followed.id)
      if following && following.destroy
        flash[:success] = "You are no longer following this user"
        redirect_to :back
      else
        flash[:danger] = "Unable to remove following because you weren't following the user to begin with!"
        redirect_to users_path
      end
    else
      flash[:danger] = "User doesn't exist!"
      redirect_to users_path
    end
  end

  private

  def follow_params
    params.permit(:id)
  end
end
