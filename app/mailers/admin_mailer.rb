class AdminMailer < ActionMailer::Base
  default from: "new_user@ambitionspotlight.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.invitation_mailer.invite.subject
  #
  def notify_about_sign_up(user, admin)
    @user = user
    mail(:to => admin.email, :subject => "New User | #{user.name}", :reply_to => "new_user@ambitionspotlight.com")
  end
end
