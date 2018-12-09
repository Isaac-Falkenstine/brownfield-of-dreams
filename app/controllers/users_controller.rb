class UsersController < ApplicationController
  def show
    @facade = UserDashboardFacade.new(current_user)
    # binding.pry
  end

  def new
    @user = User.new
  end

  def create
    user = User.create(user_params)
    if user.save
      session[:user_id] = user.id
      redirect_to dashboard_path
    else
      flash[:error] = 'Username already exists'
      render :new
    end
  end

  def update
    if request.env["PATH_INFO"] == "/auth/github/callback"
      token = request.env["omniauth.auth"].credentials.token
      current_user.update_attribute(:token, "token #{token}")
      current_user.update_attribute(:github_id, request.env["omniauth.auth"].uid)
    elsif request.env["PATH_INFO"] == "auth/failure"
      flash[:error] = "Authentication failed"
    end
    redirect_to dashboard_path
  end

  private

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :password)
  end

end
