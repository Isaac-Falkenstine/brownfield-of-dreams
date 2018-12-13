class UserVideosController < ApplicationController

  def create
    user_video = UserVideo.new(user_video_params)
    if current_user.user_videos.find_by(video_id: user_video.video_id)
      flash[:error] = "Already in your bookmarks"
    elsif user_video.save
      flash[:success] = "Bookmark added to your dashboard!"
    end

    redirect_back(fallback_location: root_path)
  end

  private

  def user_video_params
    params.permit(:user_id, :video_id)
  end
end
