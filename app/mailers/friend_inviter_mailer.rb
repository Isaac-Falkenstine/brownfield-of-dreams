class FriendInviterMailer < ApplicationMailer

  def invite(sender, recipient)
    @sender = sender
    @recipient = recipient
    mail(to: recipient.email, 
         subject: "#{sender.name} has invited you to join Turing Tutorials.")
  end

end
