class UsersController < ApplicationController
  def show
    @facade = UserDashboardFacade.new(current_user)
  end

  def new
    @user = User.new
  end

  def create
    user = User.create(user_params)
    if user.save
      ActivateMailer.inform(user).deliver_now
      flash[:success] = "Logged in as #{user.first_name} #{user.last_name}"
      flash[:notice] = "This account has not yet been activated. Please check your email."
      session[:user_id] = user.id
      redirect_to dashboard_path
    else
      flash[:error] = 'This e-mail is already in use!'
      redirect_to register_path
    end
  end

  def update
    if request.env["PATH_INFO"] == "/auth/github/callback"
      token = request.env["omniauth.auth"].credentials.token
      current_user.update_attribute(:token, "token #{token}")
      current_user.update_attribute(:github_id, request.env["omniauth.auth"].uid)
      current_user.update_attribute(:github_login, request.env["omniauth.auth"].extra.raw_info.login)
    elsif request.env["PATH_INFO"] == "/auth/failure"
      flash[:error] = "Authentication failed"
    end
    redirect_to dashboard_path
  end

  def confirm_email
    user = User.find_by_status_token(params[:user_id])
    if user
      user.update_attribute(:status, "Active")
      flash[:success] = "Your account has been activated."
    else
      flash[:error] = "Sorry. User does not exist"
    end
    redirect_to root_url
  end

  private

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :password)
  end

end
