class InvitationMailer < ActionMailer::Base
  default from: "believe@ambitionspotlight.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.invitation_mailer.invite.subject
  #
  def invite(user, believer)
    @user = user
    @believer = believer

    mail(:to => user.email, :subject => "#{believer.name.nil? ? user.email : user.name} believes in you", :reply_to => "believe@ambitionspotlight.com")
  end
  
  
  
  
  
end
