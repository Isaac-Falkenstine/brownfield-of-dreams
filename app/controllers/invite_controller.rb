class InviteController < ApplicationController

  def new
  end

  def create
    @facade = InviteFacade.new(current_user, params[:login])
    if !@facade.valid_login?
      flash[:error] = "The Github handle you entered is not valid."
    elsif !@facade.valid_email?
      flash[:error] = "The Github user you selected doesn't have an email address associated with their account."
    else
      FriendInviterMailer.invite(@facade.sender, @facade.recipient).deliver_now
      flash[:notice] = "Successfully sent invite!"
    end
    redirect_to dashboard_path
  end
end