class Admin::VideosController < Admin::BaseController
  def create
    begin
      tutorial  = Tutorial.find(params[:tutorial_id])
      thumbnail = YouTube::Video.by_id(video_params[:video_id]).thumbnail
      video     = tutorial.videos.new(video_params.merge(thumbnail: thumbnail))

      video.save

      flash[:success] = "Successfully created video."
    rescue # Sorry about this. We should get more specific instead of swallowing all errors.
      flash[:error] = "Unable to create video."
    end

    redirect_to edit_admin_tutorial_path(id: tutorial.id)
  end

  private

    def video_params
      params.require(:video).permit(:title, :description, :video_id, :thumbnail, :position)
    end

end
