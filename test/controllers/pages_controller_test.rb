require 'test_helper'

class PagesControllerTest < ActionDispatch::IntegrationTest

  def setup
    @base_title = "Revground"
  end

  test "should get root" do
    get root_path
    assert_response :success
  end

  test "should get home" do
    get home_path
    assert_response :success
    assert_select "title", "#@base_title"
  end

  test "should get about" do
    get about_path
    assert_response :success
    assert_select "title", "대하여 | #@base_title"
  end

end
