class Admin::TutorialsController < Admin::BaseController
  def edit
    @tutorial = Tutorial.find(params[:id])
  end

  def create
    begin
      tutorial = Tutorial.new(new_tutorial_params)
      tutorial.save
      flash[:success] = 'Tutorial successfully created.'
      redirect_to admin_dashboard_path
    rescue ActiveRecord::RecordInvalid => e
      flash[:error] = 'Tutorial could not be created.'
      render :new
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
