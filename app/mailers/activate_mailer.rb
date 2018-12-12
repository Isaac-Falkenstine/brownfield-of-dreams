class ActivateMailer < ApplicationMailer
  def inform(user)
    @user = user
    mail(to: user.email, subject: "Activate your Brownfield account.")
  end
end
