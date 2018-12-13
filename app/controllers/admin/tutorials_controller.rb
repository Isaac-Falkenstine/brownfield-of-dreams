class Admin::TutorialsController < Admin::BaseController
  def edit
    @tutorial = Tutorial.find(params[:id])
  end

  def create
    tutorial = Tutorial.new(new_tutorial_params)
    if tutorial.save
      flash[:success] = 'Tutorial successfully created.'
      redirect_to admin_dashboard_path
    else
      flash[:error] = 'Tutorial could not be created.'
      redirect_to new_admin_tutorial_path
    end
  end

  def new
    @tutorial = Tutorial.new
  end

  def update
    tutorial = Tutorial.find(params[:id])
    if tutorial.update(tutorial_params)
      flash[:success] = "#{tutorial.title} tagged!"
    end
    redirect_to edit_admin_tutorial_path(tutorial)
  end

  private

  def new_tutorial_params
    params.require(:tutorial).permit(:title,
                                     :description,
                                     :thumbnail)
  end

  def tutorial_params
    params.require(:tutorial).permit(:tag_list)
  end

end
