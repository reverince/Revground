require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name: "YJ Cho", email: "yjcho@test.com", password: "1234", password_confirmation: "1234")
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "name should not be blank" do
    @user.name = "  "
    assert_not @user.valid?
  end

  test "name should not be too long" do
    @user.name = "a" * 51
    assert_not @user.valid?
  end

  test "email should not be too long" do
    @user.email = "a" * 248 + "@test.com"
    assert_not @user.valid?
  end

  test "email should be unique" do
    dup_user = @user.dup
    dup_user.email = @user.email.upcase
    @user.save
    assert_not dup_user.valid?
  end

  test "valid email should be valid" do
    valid_emails = %w(yj_cho@test.com yj.cho@test.net yj+cho@test.io yjcho@test.co.kr)
    valid_emails.each do |valid_email|
      @user.email = valid_email
      assert @user.valid?, "#{valid_email} should be valid"
    end
  end

  test "invalid email should not be valid" do
    invalid_emails = %w(yjcho test.com yjcho@test. yjcho@.com yjcho@test,com yjcho@test+test.com)
    invalid_emails.each do |invalid_email|
      @user.email = invalid_email
      assert_not @user.valid?, "#{invalid_email} should not be valid"
    end
  end

  test "email addresses should be saved as lower-case" do
    mixed_case_email = "YJCho@TeST.CoM"
    @user.email = mixed_case_email
    @user.save
    assert_equal mixed_case_email.downcase, @user.reload.email
  end

  test "password should not be blank" do
    @user.password = @user.password_confirmation = "  "
    assert_not @user.valid?
  end

  test "password should not be too short" do
    @user.password = @user.password_confirmation = "a" * 3
    assert_not @user.valid?
  end

  test "associated microposts should be destroyed" do
    @user.save
    @user.microposts.create!(content: "Lorem ipsum")
    assert_difference 'Micropost.count', -1 do
      @user.destroy
    end
  end

  test "should follow and unfollow a user" do
    one = users(:one)
    two = users(:two)
    assert_not one.following?(two)
    one.follow(two)
    assert one.following?(two)
    assert two.followers.include?(one)
    one.unfollow(two)
    assert_not one.following?(two)
  end

  test "feed should have the right posts" do
    one = users(:one)
    two = users(:two)
    one.follow(two)
    two.unfollow(one)
    # Posts from self
    one.microposts.each do |post_self|
      assert one.feed.include?(post_self)
    end
    # Posts from followed user
    two.microposts.each do |post_following|
      assert one.feed.include?(post_following)
    end
    # Posts from unfollowed user
    one.microposts.each do |post_unfollowed|
      assert_not two.feed.include?(post_unfollowed)
    end
  end

end
