class FriendshipsController < ApplicationController
  def create
    follower = User.find(friendship_params[:user_id])
    followed = User.find(friendship_params[:followed_id])
    Friendship.create(follower: follower, followed: followed)
    redirect_to dashboard_path
  end

  private

  def friendship_params
    params.permit(:user_id, :followed_id)
  end
end