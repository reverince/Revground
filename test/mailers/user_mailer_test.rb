require 'test_helper'

class UserMailerTest < ActionMailer::TestCase
  def setup
    @user = users(:one)
  end

  test "password_reset" do
    @user.reset_token = User.new_token
    mail = UserMailer.password_reset(@user)
    assert_equal "비밀번호 재설정", mail.subject
    assert_equal [@user.email], mail.to
    assert_equal ["noreply@revground.herokuapp.com"], mail.from
  end

end
