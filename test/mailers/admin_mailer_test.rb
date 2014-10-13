require 'test_helper'

class AdminMailerTest < ActionMailer::TestCase
  test "notify_about_sign_up" do
    mail = AdminMailer.notify_about_sign_up
    assert_equal "Notify about sign up", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
