require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:fixture1)
  end

  test "should redirect update when not logged in" do
    patch user_path(@user), params: { user: { name: @user.name,
                                              email: @user.email } }
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should not allow the admin attribute to be edited via the web" do
    log_in_as(@user)
    assert_not @user.admin?
    patch user_path(@user), params: {
                                    user: { password:              "1234",
                                            password_confirmation: "1234",
                                            admin: true } }
    assert_not @user.reload.admin?
  end
end
