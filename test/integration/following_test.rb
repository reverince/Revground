require 'test_helper'

class FollowingTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:one)
    @other_user = users(:two)
    log_in_as(@user)
  end

  test "should follow a user with Ajax" do
    assert_difference '@user.following.count', 1 do
      post relationships_path, xhr: true, params: { followed_id: @other_user.id }
    end
  end

  test "should unfollow a user with Ajax" do
    @user.follow(@other_user)
    relationship = @user.active_relationships.find_by(followed_id: @other_user.id)
    assert_difference '@user.following.count', -1 do
      delete relationship_path(relationship), xhr: true
    end
  end

end
