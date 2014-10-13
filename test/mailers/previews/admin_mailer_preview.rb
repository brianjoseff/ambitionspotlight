# Preview all emails at http://localhost:3000/rails/mailers/admin_mailer
class AdminMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/admin_mailer/notify_about_sign_up
  def notify_about_sign_up
    AdminMailer.notify_about_sign_up
  end

end
